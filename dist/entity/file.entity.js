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
exports.File = void 0;
const typeorm_1 = require("typeorm");
let File = class File {
};
__decorate([
    typeorm_1.PrimaryGeneratedColumn("uuid"),
    __metadata("design:type", String)
], File.prototype, "file_id", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 150,
    }),
    __metadata("design:type", String)
], File.prototype, "file_name", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 150,
        nullable: true
    }),
    __metadata("design:type", String)
], File.prototype, "tag", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 300,
        nullable: true
    }),
    __metadata("design:type", String)
], File.prototype, "file_url", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 300,
    }),
    __metadata("design:type", String)
], File.prototype, "created_by", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 300,
    }),
    __metadata("design:type", String)
], File.prototype, "reference_id", void 0);
__decorate([
    typeorm_1.Column({
        type: "boolean",
        default: true
    }),
    __metadata("design:type", Boolean)
], File.prototype, "is_public", void 0);
__decorate([
    typeorm_1.Column({
        type: "text",
        nullable: true
    }),
    __metadata("design:type", String)
], File.prototype, "description", void 0);
__decorate([
    typeorm_1.Column({
        type: "jsonb",
        default: {}
    }),
    __metadata("design:type", Object)
], File.prototype, "meta", void 0);
__decorate([
    typeorm_1.CreateDateColumn(),
    __metadata("design:type", Date)
], File.prototype, "created_at", void 0);
__decorate([
    typeorm_1.UpdateDateColumn(),
    __metadata("design:type", Date)
], File.prototype, "updated_at", void 0);
File = __decorate([
    typeorm_1.Entity()
], File);
exports.File = File;
//# sourceMappingURL=file.entity.js.map