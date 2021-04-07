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
exports.Verification = exports.VerificationType = void 0;
const typeorm_1 = require("typeorm");
const user_entity_1 = require("./user.entity");
var VerificationType;
(function (VerificationType) {
    VerificationType[VerificationType["ENABLE_ACCOUNT"] = 0] = "ENABLE_ACCOUNT";
    VerificationType[VerificationType["FORGOT_PASSWORD"] = 1] = "FORGOT_PASSWORD";
})(VerificationType = exports.VerificationType || (exports.VerificationType = {}));
let Verification = class Verification {
    constructor(params) {
        let { user_id, verification_code, verification_type, expires_at } = params || {};
        this.user_id = user_id;
        this.verification_code = verification_code;
        this.verification_type = verification_type;
        this.expires_at = expires_at;
    }
};
__decorate([
    typeorm_1.PrimaryGeneratedColumn("uuid"),
    __metadata("design:type", String)
], Verification.prototype, "verification_id", void 0);
__decorate([
    typeorm_1.ManyToOne(() => user_entity_1.User, user => user.user_id),
    __metadata("design:type", String)
], Verification.prototype, "user_id", void 0);
__decorate([
    typeorm_1.Column({
        type: 'varchar',
        length: '50'
    }),
    __metadata("design:type", String)
], Verification.prototype, "verification_code", void 0);
__decorate([
    typeorm_1.Column({
        type: 'varchar',
        length: '50',
        enum: VerificationType
    }),
    __metadata("design:type", String)
], Verification.prototype, "verification_type", void 0);
__decorate([
    typeorm_1.Column({
        type: 'timestamp',
    }),
    __metadata("design:type", Date)
], Verification.prototype, "expires_at", void 0);
__decorate([
    typeorm_1.CreateDateColumn(),
    __metadata("design:type", Date)
], Verification.prototype, "created_at", void 0);
__decorate([
    typeorm_1.UpdateDateColumn(),
    __metadata("design:type", Date)
], Verification.prototype, "updated_at", void 0);
Verification = __decorate([
    typeorm_1.Entity(),
    __metadata("design:paramtypes", [Object])
], Verification);
exports.Verification = Verification;
//# sourceMappingURL=verification.entity.js.map