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
exports.GameTicket = exports.GameTicketStatus = void 0;
const typeorm_1 = require("typeorm");
const user_entity_1 = require("./user.entity");
const game_entity_1 = require("./game.entity");
const game_stock_entity_1 = require("./game_stock.entity");
var GameTicketStatus;
(function (GameTicketStatus) {
    GameTicketStatus[GameTicketStatus["PENDING"] = 0] = "PENDING";
    GameTicketStatus[GameTicketStatus["PLAYING"] = 1] = "PLAYING";
    GameTicketStatus[GameTicketStatus["VERIFIED"] = 2] = "VERIFIED";
})(GameTicketStatus = exports.GameTicketStatus || (exports.GameTicketStatus = {}));
let GameTicket = class GameTicket {
    constructor(params) {
        let { game_id, game_stock_id, owner_user_id } = params || {};
        this.game_id = game_id;
        this.game_stock_id = game_stock_id;
        this.owner_user_id = owner_user_id;
    }
};
__decorate([
    typeorm_1.PrimaryGeneratedColumn("uuid"),
    __metadata("design:type", String)
], GameTicket.prototype, "game_ticket_id", void 0);
__decorate([
    typeorm_1.Column("uuid"),
    __metadata("design:type", String)
], GameTicket.prototype, "game_id", void 0);
__decorate([
    typeorm_1.ManyToOne(() => game_entity_1.Game, game => game.game_id),
    typeorm_1.JoinColumn({ name: 'game_id' }),
    __metadata("design:type", String)
], GameTicket.prototype, "game_detail", void 0);
__decorate([
    typeorm_1.Column("uuid"),
    __metadata("design:type", String)
], GameTicket.prototype, "game_stock_id", void 0);
__decorate([
    typeorm_1.ManyToOne(() => game_stock_entity_1.GameStock, game_stock => game_stock.game_stock_id),
    typeorm_1.JoinColumn({ name: 'game_stock_id' }),
    __metadata("design:type", user_entity_1.User)
], GameTicket.prototype, "game_stock_detail", void 0);
__decorate([
    typeorm_1.Column("uuid"),
    __metadata("design:type", String)
], GameTicket.prototype, "owner_user_id", void 0);
__decorate([
    typeorm_1.ManyToOne(() => user_entity_1.User, user => user.user_id),
    typeorm_1.JoinColumn({ name: 'owner_user_id' }),
    __metadata("design:type", user_entity_1.User)
], GameTicket.prototype, "owner_user_detail", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        enum: GameTicketStatus,
        default: 'PENDING'
    }),
    __metadata("design:type", String)
], GameTicket.prototype, "game_ticket_status", void 0);
__decorate([
    typeorm_1.Column({
        type: 'boolean',
        default: false
    }),
    __metadata("design:type", Boolean)
], GameTicket.prototype, "isPaid", void 0);
__decorate([
    typeorm_1.CreateDateColumn(),
    __metadata("design:type", Date)
], GameTicket.prototype, "created_at", void 0);
__decorate([
    typeorm_1.UpdateDateColumn(),
    __metadata("design:type", Date)
], GameTicket.prototype, "updated_at", void 0);
GameTicket = __decorate([
    typeorm_1.Entity(),
    __metadata("design:paramtypes", [Object])
], GameTicket);
exports.GameTicket = GameTicket;
//# sourceMappingURL=game_ticket.entity.js.map