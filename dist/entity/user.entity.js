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
exports.User = exports.UserRoles = exports.UserStatus = void 0;
const typeorm_1 = require("typeorm");
var UserStatus;
(function (UserStatus) {
    UserStatus[UserStatus["INITIAL"] = 0] = "INITIAL";
    UserStatus[UserStatus["ENABLED"] = 1] = "ENABLED";
    UserStatus[UserStatus["DISABLED"] = 2] = "DISABLED";
})(UserStatus = exports.UserStatus || (exports.UserStatus = {}));
var UserRoles;
(function (UserRoles) {
    UserRoles[UserRoles["ADMIN"] = 0] = "ADMIN";
    UserRoles[UserRoles["NORMAL_USER"] = 1] = "NORMAL_USER";
})(UserRoles = exports.UserRoles || (exports.UserRoles = {}));
let User = class User {
};
__decorate([
    typeorm_1.PrimaryGeneratedColumn("uuid"),
    __metadata("design:type", String)
], User.prototype, "user_id", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 150,
    }),
    __metadata("design:type", String)
], User.prototype, "profile_name", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 150,
        unique: true,
    }),
    __metadata("design:type", String)
], User.prototype, "email", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        length: 150,
        select: false,
        nullable: true
    }),
    __metadata("design:type", String)
], User.prototype, "password", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        enum: UserStatus,
        default: "INITIAL",
        length: 50,
    }),
    __metadata("design:type", String)
], User.prototype, "user_status", void 0);
__decorate([
    typeorm_1.Column({
        type: "varchar",
        enum: UserRoles,
        default: "NORMAL_USER",
        length: 50,
    }),
    __metadata("design:type", String)
], User.prototype, "user_role", void 0);
__decorate([
    typeorm_1.CreateDateColumn(),
    __metadata("design:type", Date)
], User.prototype, "created_at", void 0);
__decorate([
    typeorm_1.UpdateDateColumn(),
    __metadata("design:type", Date)
], User.prototype, "updated_at", void 0);
User = __decorate([
    typeorm_1.Entity()
], User);
exports.User = User;
//# sourceMappingURL=user.entity.js.map