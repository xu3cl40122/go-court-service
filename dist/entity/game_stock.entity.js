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
exports.GameStock = void 0;
const typeorm_1 = require("typeorm");
const game_entity_1 = require("./game.entity");
let GameStock = class GameStock {
};
__decorate([
    typeorm_1.PrimaryGeneratedColumn("uuid"),
    __metadata("design:type", String)
], GameStock.prototype, "game_stock_id", void 0);
__decorate([
    typeorm_1.Column("uuid"),
    __metadata("design:type", String)
], GameStock.prototype, "game_id", void 0);
__decorate([
    typeorm_1.ManyToOne(() => game_entity_1.Game, game => game.game_id),
    typeorm_1.JoinColumn({ name: 'game_id' }),
    __metadata("design:type", String)
], GameStock.prototype, "game_detail", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 100
    }),
    __metadata("design:type", String)
], GameStock.prototype, "spec_name", void 0);
__decorate([
    typeorm_1.Column('integer'),
    __metadata("design:type", Number)
], GameStock.prototype, "stock_amount", void 0);
__decorate([
    typeorm_1.Column({
        type: "integer",
    }),
    __metadata("design:type", Number)
], GameStock.prototype, "price", void 0);
__decorate([
    typeorm_1.CreateDateColumn(),
    __metadata("design:type", Date)
], GameStock.prototype, "created_at", void 0);
__decorate([
    typeorm_1.UpdateDateColumn(),
    __metadata("design:type", Date)
], GameStock.prototype, "updated_at", void 0);
GameStock = __decorate([
    typeorm_1.Entity(),
    typeorm_1.Check(`"stock_amount" > 0`)
], GameStock);
exports.GameStock = GameStock;
//# sourceMappingURL=game_stock.entity.js.map