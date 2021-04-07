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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserController = void 0;
const common_1 = require("@nestjs/common");
const users_service_1 = require("./users.service");
const message_service_1 = require("../message/message.service");
const jwt_guard_1 = require("../auth/jwt.guard");
let UserController = class UserController {
    constructor(userService, messageService) {
        this.userService = userService;
        this.messageService = messageService;
    }
    register(reqBody) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.userService.addUser(reqBody)
                .catch(error => {
                if (error.code === '23505')
                    throw new common_1.HttpException('duplicate email', common_1.HttpStatus.BAD_REQUEST);
                throw new common_1.HttpException('INTERNAL_SERVER_ERROR', common_1.HttpStatus.INTERNAL_SERVER_ERROR);
            });
        });
    }
    // 發 email 驗證碼
    sendVerification(reqBody) {
        return __awaiter(this, void 0, void 0, function* () {
            let verification_type = 'ENABLE_ACCOUNT';
            return this.userService.sendVerification(reqBody.email, verification_type)
                .catch(error => {
                if (error === 'user not found')
                    throw new common_1.HttpException(error, common_1.HttpStatus.BAD_REQUEST);
                if (error === 'not initial user')
                    throw new common_1.HttpException(error, common_1.HttpStatus.BAD_REQUEST);
                if (error === 'request later')
                    throw new common_1.HttpException(error, common_1.HttpStatus.NOT_ACCEPTABLE);
                throw new common_1.HttpException('INTERNAL_SERVER_ERROR', common_1.HttpStatus.INTERNAL_SERVER_ERROR);
            });
        });
    }
    // 透過 email 驗證碼啟用帳號
    enableUser(req, body) {
        return __awaiter(this, void 0, void 0, function* () {
            let { verification_code, email } = body;
            return this.userService.enableUser(email, verification_code)
                .catch(error => {
                if (error === 'user not found')
                    throw new common_1.HttpException(error, common_1.HttpStatus.BAD_REQUEST);
                if (error === 'code expired')
                    throw new common_1.HttpException(error, common_1.HttpStatus.NOT_ACCEPTABLE);
                if (error === 'wrong verification code')
                    throw new common_1.HttpException(error, common_1.HttpStatus.BAD_REQUEST);
                throw new common_1.HttpException('INTERNAL_SERVER_ERROR', common_1.HttpStatus.INTERNAL_SERVER_ERROR);
            });
        });
    }
    getSelfProfile(req) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.userService.findUser({ user_id: req.payload.user_id });
        });
    }
    updateSelfProfile(req, userData) {
        return __awaiter(this, void 0, void 0, function* () {
            let { raw, affected } = yield this.userService.editUser(req.payload.user_id, userData);
            if (affected === 0 || !(raw === null || raw === void 0 ? void 0 : raw[0]))
                throw new common_1.HttpException('user_id not found', common_1.HttpStatus.BAD_REQUEST);
            return raw[0];
        });
    }
    queryUsers(reqQuery) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.userService.queryUsers(reqQuery);
        });
    }
    user(user_id) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.userService.findUser({ user_id });
        });
    }
    updateUserById(id, userData) {
        return __awaiter(this, void 0, void 0, function* () {
            let user = yield this.userService.editUser(id, userData);
            if (!user)
                throw new common_1.HttpException('user_id not found', common_1.HttpStatus.BAD_REQUEST);
            return user;
        });
    }
};
__decorate([
    common_1.Post('register'),
    __param(0, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "register", null);
__decorate([
    common_1.Put('users/verification'),
    __param(0, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "sendVerification", null);
__decorate([
    common_1.Put('users/enable'),
    __param(0, common_1.Req()), __param(1, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "enableUser", null);
__decorate([
    common_1.Get('profile'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "getSelfProfile", null);
__decorate([
    common_1.Put('profile'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "updateSelfProfile", null);
__decorate([
    common_1.Get('users'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Query()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "queryUsers", null);
__decorate([
    common_1.Get('users/:user_id'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Param('user_id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "user", null);
__decorate([
    common_1.Put('users/:user_id'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Param('user_id')), __param(1, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "updateUserById", null);
UserController = __decorate([
    common_1.Controller(),
    __metadata("design:paramtypes", [users_service_1.UsersService,
        message_service_1.MessageService])
], UserController);
exports.UserController = UserController;
//# sourceMappingURL=users.controller.js.map