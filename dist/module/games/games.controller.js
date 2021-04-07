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
exports.GamesController = void 0;
const common_1 = require("@nestjs/common");
const games_service_1 = require("./games.service");
const jwt_guard_1 = require("../auth/jwt.guard");
let GamesController = class GamesController {
    constructor(gamesService) {
        this.gamesService = gamesService;
    }
    queryGames(query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.gamesService.queryGames(query);
        });
    }
    getMyTickets(req, query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.gamesService.queryTicketsOfUserId(req.payload.user_id, query);
        });
    }
    findGamesOfHost(req, query) {
        return __awaiter(this, void 0, void 0, function* () {
            let host_user_id = req.payload.user_id;
            return yield this.gamesService.findGamesOfHost(host_user_id, query);
        });
    }
    getGameById(game_id) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.gamesService.findGame({ game_id });
        });
    }
    addGame(req, body) {
        return __awaiter(this, void 0, void 0, function* () {
            body.host_user_id = req.payload.user_id;
            return yield this.gamesService.addGame(body);
        });
    }
    updateGame(req, game_id, body) {
        return __awaiter(this, void 0, void 0, function* () {
            let game = yield this.gamesService.findGame({ game_id });
            if (game.host_user_id !== req.payload.user_id)
                throw new common_1.HttpException('only admin or host user can update', common_1.HttpStatus.FORBIDDEN);
            body.host_user_id = req.payload.user_id;
            return yield this.gamesService.updateGame(game_id, body);
        });
    }
    updateGameStock(req, game_id, stockArr) {
        return __awaiter(this, void 0, void 0, function* () {
            let game = yield this.gamesService.findGame({ game_id });
            if (!game)
                throw new common_1.HttpException('game not found', common_1.HttpStatus.BAD_REQUEST);
            if (game.host_user_id !== req.payload.user_id)
                throw new common_1.HttpException('only admin or host user can update', common_1.HttpStatus.FORBIDDEN);
            stockArr.forEach(stock => stock.game_id = game_id);
            return yield this.gamesService.updateGameStock(stockArr);
        });
    }
    // @Post('/:game_id/game_user')
    // @UseGuards(JwtAuthGuard)
    // async joinGameByTicket(@Req() req, @Param('game_id') game_id, @Body() body): Promise<Object> {
    //   let game = await this.gamesService.findGame({ game_id })
    //   if (!game)
    //     throw new HttpException('game not found', HttpStatus.BAD_REQUEST)
    //   if (game.host_user_id !== req.payload.user_id)
    //     throw new HttpException('only admin or host user can create game user', HttpStatus.FORBIDDEN)
    //   let { game_ticket_id, game_user_id } = body
    //   let gameTicket = await this.gamesService.findGameTicket({ game_ticket_id })
    //   if (!gameTicket || gameTicket.game_id !== game_id)
    //     throw new HttpException('wrong game ticket id', HttpStatus.BAD_REQUEST)
    //   if (gameTicket.game_ticket_status === 'PAID')
    //     throw new HttpException('this ticket was used', HttpStatus.BAD_REQUEST)
    //   return await this.gamesService.joinGameByTicket(game_user_id, game, gameTicket);
    // }
    queryGameUsers(game_id, query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.gamesService.queryGameUsers(game_id, query);
        });
    }
    queryGameTickets(game_id, query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.gamesService.queryGameTickets(game_id, query);
        });
    }
    /**
     * todo update 被用到的 game ticket 的 status
     * @param req
     * @param game_id
     * @returns
     */
    initGame(req, game_id) {
        return __awaiter(this, void 0, void 0, function* () {
            let game = yield this.gamesService.findGame({ game_id });
            if (!game)
                throw new common_1.HttpException('wrong game_id', common_1.HttpStatus.BAD_REQUEST);
            if (game.host_user_id !== req.payload.user_id)
                throw new common_1.HttpException('only admin or host user can init game', common_1.HttpStatus.FORBIDDEN);
            // if (game.game_status !== 'PENDING')
            //   throw new HttpException('you can init game which game_status is not PENDING', HttpStatus.NOT_ACCEPTABLE)
            let tickets = yield this.gamesService.getGameTickets(game_id, {});
            let idMap = {};
            let game_users = [];
            tickets.forEach(ticket => {
                let { game_id, game_stock_id, game_ticket_id, owner_user_id } = ticket;
                if (!idMap[owner_user_id]) {
                    game_users.push({ game_id, game_stock_id, game_ticket_id, game_user_id: owner_user_id });
                    idMap[owner_user_id] = ticket;
                }
            });
            return yield this.gamesService.initGame(game_id, game_users)
                .catch(error => {
                console.log(error);
                throw new common_1.HttpException('init game failed', common_1.HttpStatus.INTERNAL_SERVER_ERROR);
            });
        });
    }
    verifyTicket(req, game_id, game_ticket_id) {
        return __awaiter(this, void 0, void 0, function* () {
            let [game, gameTicket] = yield Promise.all([this.gamesService.findGame({ game_id }), this.gamesService.findGameTicket({ game_ticket_id })]);
            if (!game)
                throw new common_1.HttpException('wrong game_id', common_1.HttpStatus.BAD_REQUEST);
            if (game.host_user_id !== req.payload.user_id)
                throw new common_1.HttpException('only admin or host user can verify ticket', common_1.HttpStatus.FORBIDDEN);
            if (!gameTicket || game.game_id !== gameTicket.game_id)
                throw new common_1.HttpException('wrong ticket', common_1.HttpStatus.BAD_REQUEST);
            return yield this.gamesService.verifyTicket(gameTicket.game_ticket_id);
        });
    }
    checkout(req, carts) {
        return __awaiter(this, void 0, void 0, function* () {
            carts.forEach(d => d.owner_user_id = req.payload.user_id);
            let tickets;
            try {
                tickets = yield this.gamesService.checkout(carts);
            }
            catch (error) {
                if (error.code === '23514')
                    throw new common_1.HttpException('tickets sold out', common_1.HttpStatus.BAD_REQUEST);
                throw new common_1.HttpException('buy ticket failed', common_1.HttpStatus.INTERNAL_SERVER_ERROR);
            }
            return { tickets };
        });
    }
};
__decorate([
    common_1.Get(),
    __param(0, common_1.Query()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "queryGames", null);
__decorate([
    common_1.Get('/tickets'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Query()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "getMyTickets", null);
__decorate([
    common_1.Get('/host'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Query()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "findGamesOfHost", null);
__decorate([
    common_1.Get('/:game_id'),
    __param(0, common_1.Param('game_id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "getGameById", null);
__decorate([
    common_1.Post(),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "addGame", null);
__decorate([
    common_1.Put('/:game_id'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Param('game_id')), __param(2, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "updateGame", null);
__decorate([
    common_1.Put('/:game_id/stock'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Param('game_id')), __param(2, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "updateGameStock", null);
__decorate([
    common_1.Get('/:game_id/game_users'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Param('game_id')), __param(1, common_1.Query()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "queryGameUsers", null);
__decorate([
    common_1.Get('/:game_id/tickets'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Param('game_id')), __param(1, common_1.Query()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "queryGameTickets", null);
__decorate([
    common_1.Put('/:game_id/init'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Param('game_id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "initGame", null);
__decorate([
    common_1.Put('/:game_id/tickets/:game_ticket_id/verify'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Param('game_id')), __param(2, common_1.Param('game_ticket_id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "verifyTicket", null);
__decorate([
    common_1.Post('/checkout'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], GamesController.prototype, "checkout", null);
GamesController = __decorate([
    common_1.Controller('games'),
    __metadata("design:paramtypes", [games_service_1.GamesService])
], GamesController);
exports.GamesController = GamesController;
//# sourceMappingURL=games.controller.js.map