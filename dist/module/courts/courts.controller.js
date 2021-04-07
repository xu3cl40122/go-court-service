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
exports.CourtController = void 0;
const common_1 = require("@nestjs/common");
const courts_service_1 = require("./courts.service");
const jwt_guard_1 = require("../auth/jwt.guard");
let CourtController = class CourtController {
    constructor(courtService) {
        this.courtService = courtService;
    }
    queryCourts(query) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.courtService.queryCourts(query);
        });
    }
    searchCourt(query) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.courtService.searchCourt(query);
        });
    }
    getGameById(court_id) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.courtService.findCourt({ court_id });
        });
    }
    addCourt(body) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.courtService.addCourt(body);
        });
    }
    updateCourtById(court_id, body) {
        return __awaiter(this, void 0, void 0, function* () {
            let court = yield this.courtService.updateCourtById(court_id, body);
            if (!court)
                throw new common_1.HttpException('user_id not found', common_1.HttpStatus.BAD_REQUEST);
            return court;
        });
    }
};
__decorate([
    common_1.Get(),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Query()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], CourtController.prototype, "queryCourts", null);
__decorate([
    common_1.Get('/search'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Query()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], CourtController.prototype, "searchCourt", null);
__decorate([
    common_1.Get('/:court_id'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Param('court_id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], CourtController.prototype, "getGameById", null);
__decorate([
    common_1.Post(),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], CourtController.prototype, "addCourt", null);
__decorate([
    common_1.Put('/:court_id'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Param('court_id')), __param(1, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], CourtController.prototype, "updateCourtById", null);
CourtController = __decorate([
    common_1.Controller('courts'),
    __metadata("design:paramtypes", [courts_service_1.CourtService])
], CourtController);
exports.CourtController = CourtController;
//# sourceMappingURL=courts.controller.js.map