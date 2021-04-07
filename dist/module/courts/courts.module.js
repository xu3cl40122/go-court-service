"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CourtModule = void 0;
const common_1 = require("@nestjs/common");
const courts_service_1 = require("./courts.service");
const courts_controller_1 = require("./courts.controller");
const typeorm_1 = require("@nestjs/typeorm");
const court_entity_1 = require("../../entity/court.entity");
let CourtModule = class CourtModule {
};
CourtModule = __decorate([
    common_1.Module({
        // 要把要用到 Repository import 進來
        imports: [typeorm_1.TypeOrmModule.forFeature([court_entity_1.Court])],
        providers: [courts_service_1.CourtService],
        controllers: [courts_controller_1.CourtController]
    })
], CourtModule);
exports.CourtModule = CourtModule;
//# sourceMappingURL=courts.module.js.map