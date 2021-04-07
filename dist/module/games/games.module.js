"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.GamesModule = void 0;
const common_1 = require("@nestjs/common");
const games_service_1 = require("./games.service");
const games_controller_1 = require("./games.controller");
const typeorm_1 = require("@nestjs/typeorm");
const game_entity_1 = require("../../entity/game.entity");
const game_user_entity_1 = require("../../entity/game_user.entity");
const game_ticket_entity_1 = require("../../entity/game_ticket.entity");
const game_stock_entity_1 = require("../../entity/game_stock.entity");
let GamesModule = class GamesModule {
};
GamesModule = __decorate([
    common_1.Module({
        // 要把要用到 Repository import 進來
        imports: [
            typeorm_1.TypeOrmModule.forFeature([game_entity_1.Game, game_user_entity_1.GameUser, game_ticket_entity_1.GameTicket, game_stock_entity_1.GameStock])
        ],
        providers: [games_service_1.GamesService],
        controllers: [games_controller_1.GamesController]
    })
], GamesModule);
exports.GamesModule = GamesModule;
//# sourceMappingURL=games.module.js.map