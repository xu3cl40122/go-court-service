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
exports.CourtService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const court_entity_1 = require("../../entity/court.entity");
const typeorm_3 = require("typeorm");
let CourtService = class CourtService {
    constructor(courtsRepository) {
        this.courtsRepository = courtsRepository;
    }
    queryCourts(query) {
        var _a, _b;
        return __awaiter(this, void 0, void 0, function* () {
            let [page, size] = [Number((_a = query.page) !== null && _a !== void 0 ? _a : 0), Number((_b = query.size) !== null && _b !== void 0 ? _b : 10)];
            let where = {};
            let filters = ['city_code', 'dist_code'];
            filters.forEach(key => query[key] ? where[key] = query[key] : '');
            let [content, total] = yield this.courtsRepository.findAndCount({
                where,
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
    findCourt(query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.courtsRepository.findOne({
                where: query,
            });
        });
    }
    /**
     * 待研究 like 好像不能和其他參數混用
     */
    searchCourt(query) {
        return __awaiter(this, void 0, void 0, function* () {
            let option = {};
            if (query.name)
                option.name = typeorm_3.ILike(`%${query.name}%`);
            let courts = yield this.courtsRepository.find(option);
            // let courts = await this.courtsRepository.find({
            //   name: ILike(`%${query.name}%`)
            // })
            return courts;
        });
    }
    addCourt(courtData) {
        return __awaiter(this, void 0, void 0, function* () {
            const court = new court_entity_1.Court();
            let columns = [
                'name',
                'address',
                'city_code',
                'dist_code',
                'latitude',
                'longitude',
                'phone',
                'logo_url',
                'description',
                'open_status',
            ];
            columns.forEach(key => court[key] = courtData[key]);
            let { raw } = yield this.courtsRepository
                .createQueryBuilder()
                .insert()
                .into('court')
                .values(Object.assign(Object.assign({}, court), { geometry: () => `ST_SetSRID(ST_MakePoint(${court.longitude}, ${court.latitude}), 4326)` }))
                .returning('*')
                .execute();
            return raw[0];
        });
    }
    updateCourtById(court_id, courtData) {
        return __awaiter(this, void 0, void 0, function* () {
            const court = new court_entity_1.Court();
            let columns = [
                'name',
                'address',
                'city_code',
                'dist_code',
                'latitude',
                'longitude',
                'phone',
                'logo_url',
                'description',
                'open_status',
            ];
            columns.forEach(key => court[key] = courtData[key]);
            let { raw } = yield this.courtsRepository
                .createQueryBuilder()
                .update(court_entity_1.Court)
                .set(Object.assign(Object.assign({}, court), { geometry: () => `ST_SetSRID(ST_MakePoint(${court.longitude}, ${court.latitude}), 4326)` }))
                .where("court_id = :court_id", { court_id })
                .returning('*')
                .execute();
            return raw === null || raw === void 0 ? void 0 : raw[0];
        });
    }
};
CourtService = __decorate([
    common_1.Injectable(),
    __param(0, typeorm_1.InjectRepository(court_entity_1.Court)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], CourtService);
exports.CourtService = CourtService;
//# sourceMappingURL=courts.service.js.map