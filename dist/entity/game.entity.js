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
Object.defineProperty(exports, "__esModule", { value: true });
exports.Game = exports.GameStatus = exports.GameType = exports.CourtType = void 0;
const typeorm_1 = require("typeorm");
const user_entity_1 = require("./user.entity");
const court_entity_1 = require("./court.entity");
const game_stock_entity_1 = require("./game_stock.entity");
var CourtType;
(function (CourtType) {
    CourtType[CourtType["INDOOR"] = 0] = "INDOOR";
    CourtType[CourtType["COVERED"] = 1] = "COVERED";
    CourtType[CourtType["OUTDOOR"] = 2] = "OUTDOOR";
})(CourtType = exports.CourtType || (exports.CourtType = {}));
var GameType;
(function (GameType) {
    GameType[GameType["MALE_NET"] = 0] = "MALE_NET";
    GameType[GameType["FEMALE_NET_MIX"] = 1] = "FEMALE_NET_MIX";
    GameType[GameType["FEMAL_NET_PURE"] = 2] = "FEMAL_NET_PURE";
    GameType[GameType["BEACH"] = 3] = "BEACH";
})(GameType = exports.GameType || (exports.GameType = {}));
var GameStatus;
(function (GameStatus) {
    GameStatus[GameStatus["PENDING"] = 0] = "PENDING";
    GameStatus[GameStatus["PLAYING"] = 1] = "PLAYING";
    GameStatus[GameStatus["FINISHED"] = 2] = "FINISHED";
})(GameStatus = exports.GameStatus || (exports.GameStatus = {}));
let Game = class Game {
};
__decorate([
    typeorm_1.PrimaryGeneratedColumn("uuid"),
    __metadata("design:type", String)
], Game.prototype, "game_id", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 150,
    }),
    __metadata("design:type", String)
], Game.prototype, "game_name", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
    }),
    __metadata("design:type", String)
], Game.prototype, "host_user_id", void 0);
__decorate([
    typeorm_1.ManyToOne(() => user_entity_1.User, user => user.user_id),
    typeorm_1.JoinColumn({ name: 'host_user_id' }),
    __metadata("design:type", user_entity_1.User)
], Game.prototype, "host_user_detail", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
    }),
    __metadata("design:type", String)
], Game.prototype, "court_id", void 0);
__decorate([
    typeorm_1.ManyToOne(() => court_entity_1.Court, court => court.court_id),
    typeorm_1.JoinColumn({ name: 'court_id' }),
    __metadata("design:type", court_entity_1.Court)
], Game.prototype, "court_detail", void 0);
__decorate([
    typeorm_1.OneToMany(() => game_stock_entity_1.GameStock, gameStock => gameStock.game_detail),
    __metadata("design:type", Array)
], Game.prototype, "game_stock", void 0);
__decorate([
    typeorm_1.Column({
        type: "timestamp",
    }),
    __metadata("design:type", Date)
], Game.prototype, "game_start_at", void 0);
__decorate([
    typeorm_1.Column({
        type: "timestamp",
    }),
    __metadata("design:type", Date)
], Game.prototype, "game_end_at", void 0);
__decorate([
    typeorm_1.Column({
        type: "timestamp",
    }),
    __metadata("design:type", Date)
], Game.prototype, "sell_start_at", void 0);
__decorate([
    typeorm_1.Column({
        type: "timestamp",
    }),
    __metadata("design:type", Date)
], Game.prototype, "sell_end_at", void 0);
__decorate([
    typeorm_1.Column({
        type: "integer",
        nullable: true
    }),
    __metadata("design:type", Number)
], Game.prototype, "total_player_number", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        enum: CourtType
    }),
    __metadata("design:type", String)
], Game.prototype, "court_type", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        enum: GameType
    }),
    __metadata("design:type", String)
], Game.prototype, "game_type", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        nullable: true,
    }),
    __metadata("design:type", String)
], Game.prototype, "description", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        enum: GameStatus,
        default: 'PENDING'
    }),
    __metadata("design:type", String)
], Game.prototype, "game_status", void 0);
__decorate([
    typeorm_1.Column({
        type: "jsonb",
        default: {}
    }),
    __metadata("design:type", Object)
], Game.prototype, "meta", void 0);
__decorate([
    typeorm_1.Column({
        type: 'boolean',
        default: false
    }),
    __metadata("design:type", Boolean)
], Game.prototype, "is_public", void 0);
__decorate([
    typeorm_1.Column({
        type: 'boolean',
        default: false
    }),
    __metadata("design:type", Boolean)
], Game.prototype, "is_free", void 0);
__decorate([
    typeorm_1.Column({
        type: 'boolean',
        default: false
    }),
    __metadata("design:type", Boolean)
], Game.prototype, "deleted", void 0);
__decorate([
    typeorm_1.CreateDateColumn(),
    __metadata("design:type", Date)
], Game.prototype, "created_at", void 0);
__decorate([
    typeorm_1.UpdateDateColumn(),
    __metadata("design:type", Date)
], Game.prototype, "updated_at", void 0);
Game = __decorate([
    typeorm_1.Entity()
], Game);
exports.Game = Game;
//# sourceMappingURL=game.entity.js.map