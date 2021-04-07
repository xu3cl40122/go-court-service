"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.GamesService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const game_entity_1 = require("../../entity/game.entity");
const game_user_entity_1 = require("../../entity/game_user.entity");
const game_ticket_entity_1 = require("../../entity/game_ticket.entity");
const game_stock_entity_1 = require("../../entity/game_stock.entity");
let GamesService = class GamesService {
    constructor(gamesRepository, gameUsersRepository, gameTicketsRepository, gameStockRepository) {
        this.gamesRepository = gamesRepository;
        this.gameUsersRepository = gameUsersRepository;
        this.gameTicketsRepository = gameTicketsRepository;
        this.gameStockRepository = gameStockRepository;
    }
    // game part 
    findGame(query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.gamesRepository.findOne({
                where: query,
                relations: ["host_user_detail", "game_stock", "court_detail"],
            });
        });
    }
    queryGames(query) {
        var _a, _b;
        return __awaiter(this, void 0, void 0, function* () {
            let [page, size] = [Number((_a = query.page) !== null && _a !== void 0 ? _a : 0), Number((_b = query.size) !== null && _b !== void 0 ? _b : 10)];
            let { city_code, dist_code, court_type, game_type, start, end } = query;
            let nowIsoTime = new Date().toISOString();
            let where = {
                is_public: true
            };
            if (court_type)
                where.court_type = typeorm_2.In(court_type.split(','));
            if (game_type)
                where.game_type = typeorm_2.In(game_type.split(','));
            if (start)
                where.game_start_at = typeorm_2.MoreThanOrEqual(start);
            if (end)
                where.game_end_at = typeorm_2.LessThanOrEqual(end);
            let [content, total] = yield this.gamesRepository.findAndCount({
                join: {
                    alias: "game",
                    leftJoinAndSelect: {
                        court: "game.court_detail",
                    }
                },
                where: qb => {
                    // filter game 自己
                    let sql = qb.where(where);
                    // Filter join 來的 table
                    if (city_code)
                        sql = sql.andWhere('city_code = :city_code', { city_code });
                    if (dist_code)
                        sql = sql.andWhere('dist_code = :dist_code', { dist_code });
                },
                take: size,
                skip: page * size,
                relations: ["host_user_detail", "game_stock"],
                order: {
                    created_at: "DESC"
                }
            });
            let totalPage = Math.ceil(total / size);
            return { content, page, size, total, totalPage };
        });
    }
    findGamesOfHost(host_user_id, query) {
        var _a, _b;
        return __awaiter(this, void 0, void 0, function* () {
            let [page, size] = [Number((_a = query.page) !== null && _a !== void 0 ? _a : 0), Number((_b = query.size) !== null && _b !== void 0 ? _b : 10)];
            let [content, total] = yield this.gamesRepository.findAndCount({
                where: {
                    host_user_id,
                },
                take: size,
                skip: page * size,
                relations: ["host_user_detail", "game_stock", "court_detail"],
            });
            let totalPage = Math.ceil(total / size);
            return { content, page, size, total, totalPage };
        });
    }
    addGame(gameData) {
        return __awaiter(this, void 0, void 0, function* () {
            const game = new game_entity_1.Game();
            let columns = [
                'game_name',
                'host_user_id',
                'court_id',
                'game_start_at',
                'game_end_at',
                'sell_start_at',
                'sell_end_at',
                'total_player_number',
                'court_type',
                'game_type',
                'description',
                'is_public',
                'deleted',
            ];
            columns.forEach(key => game[key] = gameData[key]);
            return yield this.gamesRepository.save(game);
        });
    }
    updateGame(game_id, gameData) {
        return __awaiter(this, void 0, void 0, function* () {
            const game = new game_entity_1.Game();
            let columns = [
                'game_name',
                'host_user_id',
                'court_id',
                'game_start_at',
                'game_end_at',
                'sell_start_at',
                'sell_end_at',
                'total_player_number',
                'court_type',
                'game_type',
                'description',
                'is_public',
                'deleted',
            ];
            columns.forEach(key => game[key] = gameData[key]);
            let { raw } = yield this.gamesRepository
                .createQueryBuilder()
                .update(game_entity_1.Game)
                .set(game)
                .where("game_id = :game_id", { game_id })
                .returning('*')
                .execute();
            raw.forEach(user => delete user.email);
            return raw === null || raw === void 0 ? void 0 : raw[0];
        });
    }
    updateGameStock(stockArr) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.gameStockRepository.save(stockArr);
        });
    }
    // ticket part
    checkout(carts) {
        return __awaiter(this, void 0, void 0, function* () {
            let resArr = [];
            yield typeorm_2.getManager().transaction((manager) => __awaiter(this, void 0, void 0, function* () {
                for (let cartItem of carts) {
                    let { game_stock_id, stock_amount, owner_user_id } = cartItem;
                    let { raw, affected } = yield manager.createQueryBuilder()
                        .update(game_stock_entity_1.GameStock)
                        .set({ stock_amount: () => `stock_amount - ${stock_amount}` })
                        .where("game_stock_id = :game_stock_id", { game_stock_id })
                        .returning('*')
                        .execute();
                    if (affected !== 1)
                        throw 'wrong stock_id';
                    let { game_id } = raw[0];
                    let gameTicketArr = Array(stock_amount).fill('').map(d => {
                        return new game_ticket_entity_1.GameTicket({ game_id, game_stock_id, owner_user_id });
                    });
                    let newTickets = yield manager.save(gameTicketArr);
                    resArr.push(...newTickets);
                }
            }));
            return resArr;
        });
    }
    findGameTicket(queryObj) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.gameTicketsRepository.findOne(queryObj);
        });
    }
    queryTicketsOfUserId(owner_user_id, reqQuery) {
        var _a, _b;
        return __awaiter(this, void 0, void 0, function* () {
            let [page, size] = [Number((_a = reqQuery.page) !== null && _a !== void 0 ? _a : 0), Number((_b = reqQuery.size) !== null && _b !== void 0 ? _b : 10)];
            let [content, total] = yield this.gameTicketsRepository.findAndCount({
                take: size,
                skip: page * size,
                relations: ['game_detail', 'game_detail.court_detail', 'game_stock_detail'],
                where: [{ owner_user_id }],
                order: {
                    created_at: 'DESC'
                }
            });
            let totalPage = Math.ceil(total / size);
            return { content, page, size, total, totalPage };
        });
    }
    getGameTickets(game_id, option) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.gameTicketsRepository.find({
                where: [{ game_id }],
                relations: option.relations,
                order: {
                    created_at: "DESC"
                }
            });
        });
    }
    queryGameTickets(game_id, query) {
        var _a, _b;
        return __awaiter(this, void 0, void 0, function* () {
            let [page, size] = [Number((_a = query.page) !== null && _a !== void 0 ? _a : 0), Number((_b = query.size) !== null && _b !== void 0 ? _b : 10)];
            let [content, total] = yield this.gameTicketsRepository.findAndCount({
                where: [{ game_id }],
                relations: ["game_stock_detail", 'owner_user_detail'],
                take: size,
                skip: page * size,
                order: {
                    created_at: "DESC"
                }
            });
            let totalPage = Math.ceil(total / size);
            return { content, page, size, total, totalPage };
        });
    }
    verifyTicket(gaem_ticket_id) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.gameTicketsRepository.update(gaem_ticket_id, { game_ticket_status: 'VERIFIED' });
        });
    }
    joinGameByTicket(game_user_id, game, gameTicket) {
        return __awaiter(this, void 0, void 0, function* () {
            let { game_stock_id, game_ticket_id } = gameTicket;
            let { game_id } = game;
            return yield typeorm_2.getManager().transaction((manager) => __awaiter(this, void 0, void 0, function* () {
                yield manager.createQueryBuilder()
                    .update(game_ticket_entity_1.GameTicket)
                    .set({ game_ticket_status: 'PAID' })
                    .where("game_ticket_id = :game_ticket_id", { game_ticket_id })
                    .execute();
                let gameUser = new game_user_entity_1.GameUser({ game_id, game_stock_id, game_ticket_id, game_user_id });
                return yield manager.save(gameUser);
            }));
        });
    }
    // game user part
    initGame(game_id, game_users) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield typeorm_2.getManager().transaction((manager) => __awaiter(this, void 0, void 0, function* () {
                yield manager.insert(game_user_entity_1.GameUser, game_users);
                let ticket_ids = game_users.map(d => d.game_ticket_id);
                yield manager
                    .createQueryBuilder()
                    .update(game_ticket_entity_1.GameTicket)
                    .set({ game_ticket_status: 'PLAYING' })
                    .where({ game_ticket_id: typeorm_2.In(ticket_ids) })
                    .execute();
                yield manager.update(game_entity_1.Game, game_id, { game_status: 'PLAYING' });
            }));
        });
    }
    queryGameUsers(game_id, query) {
        var _a, _b;
        return __awaiter(this, void 0, void 0, function* () {
            let [page, size] = [Number((_a = query.page) !== null && _a !== void 0 ? _a : 0), Number((_b = query.size) !== null && _b !== void 0 ? _b : 10)];
            let [content, total] = yield this.gameUsersRepository.findAndCount({
                where: [{ game_id }],
                relations: ["game_ticket_detail", "game_stock_detail", 'game_user_detail'],
                take: size,
                skip: page * size,
                order: {
                    created_at: "DESC"
                }
            });
            let totalPage = Math.ceil(total / size);
            return { content, page, size, total, totalPage };
        });
    }
    addGameUsers(game_users) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.gameUsersRepository.insert(game_users);
        });
    }
};
GamesService = __decorate([
    common_1.Injectable(),
    __param(0, typeorm_1.InjectRepository(game_entity_1.Game)),
    __param(1, typeorm_1.InjectRepository(game_user_entity_1.GameUser)),
    __param(2, typeorm_1.InjectRepository(game_ticket_entity_1.GameTicket)),
    __param(3, typeorm_1.InjectRepository(game_stock_entity_1.GameStock)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository])
], GamesService);
exports.GamesService = GamesService;
//# sourceMappingURL=games.service.js.map