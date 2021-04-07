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
exports.GameUser = void 0;
const typeorm_1 = require("typeorm");
const user_entity_1 = require("./user.entity");
const game_ticket_entity_1 = require("./game_ticket.entity");
const game_stock_entity_1 = require("./game_stock.entity");
let GameUser = class GameUser {
    constructor(params) {
        let { game_id, game_stock_id, game_ticket_id, game_user_id } = params || {};
        this.game_id = game_id;
        this.game_stock_id = game_stock_id;
        this.game_ticket_id = game_ticket_id;
        this.game_user_id = game_user_id;
    }
};
__decorate([
    typeorm_1.PrimaryColumn("uuid"),
    __metadata("design:type", String)
], GameUser.prototype, "game_ticket_id", void 0);
__decorate([
    typeorm_1.OneToOne(() => game_ticket_entity_1.GameTicket, gameTicket => gameTicket.game_ticket_id),
    typeorm_1.JoinColumn({ name: 'game_ticket_id' }),
    __metadata("design:type", game_ticket_entity_1.GameTicket)
], GameUser.prototype, "game_ticket_detail", void 0);
__decorate([
    typeorm_1.Column("uuid"),
    __metadata("design:type", String)
], GameUser.prototype, "game_stock_id", void 0);
__decorate([
    typeorm_1.ManyToOne(() => game_stock_entity_1.GameStock, gameStock => gameStock.game_stock_id),
    typeorm_1.JoinColumn({ name: 'game_stock_id' }),
    __metadata("design:type", game_stock_entity_1.GameStock)
], GameUser.prototype, "game_stock_detail", void 0);
__decorate([
    typeorm_1.Column({
        type: "uuid",
        nullable: true
    }),
    __metadata("design:type", String)
], GameUser.prototype, "game_id", void 0);
__decorate([
    typeorm_1.Column("uuid"),
    __metadata("design:type", String)
], GameUser.prototype, "game_user_id", void 0);
__decorate([
    typeorm_1.ManyToOne(() => user_entity_1.User, user => user.user_id),
    typeorm_1.JoinColumn({ name: 'game_user_id' }),
    __metadata("design:type", user_entity_1.User)
], GameUser.prototype, "game_user_detail", void 0);
__decorate([
    typeorm_1.CreateDateColumn(),
    __metadata("design:type", Date)
], GameUser.prototype, "created_at", void 0);
__decorate([
    typeorm_1.UpdateDateColumn(),
    __metadata("design:type", Date)
], GameUser.prototype, "updated_at", void 0);
GameUser = __decorate([
    typeorm_1.Entity(),
    __metadata("design:paramtypes", [Object])
], GameUser);
exports.GameUser = GameUser;
//# sourceMappingURL=game_user.entity.js.map