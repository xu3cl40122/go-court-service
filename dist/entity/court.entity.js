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
exports.Court = exports.CourtOpenStatus = void 0;
const typeorm_1 = require("typeorm");
const game_entity_1 = require("./game.entity");
var CourtOpenStatus;
(function (CourtOpenStatus) {
    CourtOpenStatus[CourtOpenStatus["FREE"] = 0] = "FREE";
    CourtOpenStatus[CourtOpenStatus["CLOSE"] = 1] = "CLOSE";
    CourtOpenStatus[CourtOpenStatus["PAID"] = 2] = "PAID";
})(CourtOpenStatus = exports.CourtOpenStatus || (exports.CourtOpenStatus = {}));
let Court = class Court {
};
__decorate([
    typeorm_1.PrimaryGeneratedColumn("uuid"),
    __metadata("design:type", String)
], Court.prototype, "court_id", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 150,
    }),
    __metadata("design:type", String)
], Court.prototype, "name", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 150,
    }),
    __metadata("design:type", String)
], Court.prototype, "address", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 20,
        nullable: true,
    }),
    __metadata("design:type", String)
], Court.prototype, "city_code", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 20,
        nullable: true,
    }),
    __metadata("design:type", String)
], Court.prototype, "dist_code", void 0);
__decorate([
    typeorm_1.Column({
        type: "numeric",
        nullable: true,
    }),
    __metadata("design:type", Number)
], Court.prototype, "latitude", void 0);
__decorate([
    typeorm_1.Column({
        type: "numeric",
        nullable: true,
    }),
    __metadata("design:type", Number)
], Court.prototype, "longitude", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 50,
        nullable: true,
    }),
    __metadata("design:type", String)
], Court.prototype, "phone", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        nullable: true,
    }),
    __metadata("design:type", String)
], Court.prototype, "logo_url", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        nullable: true,
    }),
    __metadata("design:type", String)
], Court.prototype, "description", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        enum: CourtOpenStatus,
    }),
    __metadata("design:type", String)
], Court.prototype, "open_status", void 0);
__decorate([
    typeorm_1.Column({
        type: 'geometry',
        nullable: true,
        spatialFeatureType: 'Point',
        srid: 4326
    }),
    __metadata("design:type", String)
], Court.prototype, "geometry", void 0);
__decorate([
    typeorm_1.OneToMany(() => game_entity_1.Game, game => game.court_detail),
    __metadata("design:type", Array)
], Court.prototype, "games", void 0);
__decorate([
    typeorm_1.CreateDateColumn(),
    __metadata("design:type", Date)
], Court.prototype, "created_at", void 0);
__decorate([
    typeorm_1.UpdateDateColumn(),
    __metadata("design:type", Date)
], Court.prototype, "updated_at", void 0);
Court = __decorate([
    typeorm_1.Entity()
], Court);
exports.Court = Court;
//# sourceMappingURL=court.entity.js.map