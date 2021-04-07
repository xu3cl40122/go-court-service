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
exports.UsersService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const user_entity_1 = require("../../entity/user.entity");
const verification_entity_1 = require("../../entity/verification.entity");
const methods_1 = require("../../methods/");
const message_service_1 = require("../message/message.service");
const dayjs = require("dayjs");
const bcrypt = require("bcrypt");
let UsersService = class UsersService {
    constructor(usersRepository, verificationRepository, messageService) {
        this.usersRepository = usersRepository;
        this.verificationRepository = verificationRepository;
        this.messageService = messageService;
    }
    addUser(userData) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = new user_entity_1.User();
            let columns = [
                'profile_name',
                'email',
            ];
            columns.forEach(key => user[key] = userData[key]);
            let saltRound = 10;
            let hashedPwd = yield bcrypt.hash(userData.password, saltRound);
            user.password = hashedPwd;
            return yield this.usersRepository.save(user);
        });
    }
    sendVerification(email, verification_type, expireMinute = 5, resendMinute = 3) {
        return __awaiter(this, void 0, void 0, function* () {
            let user = yield this.findUser({ email });
            if (!user)
                throw 'user not found';
            if (user.user_status !== 'INITIAL')
                throw 'not initial user';
            let { user_id } = user;
            let lastVerification = yield this.findVerification({ user_id });
            if (lastVerification && !dayjs(lastVerification.created_at).add(resendMinute, 'minute').isBefore(dayjs()))
                throw 'request later';
            let verification_code = methods_1.generateVerificationCode();
            let expires_at = dayjs().add(expireMinute, 'minute');
            let verifaction = new verification_entity_1.Verification({ user_id, verification_type, verification_code, expires_at });
            yield this.verificationRepository.save(verifaction);
            return yield this.messageService.sendMessage({
                ToAddresses: [user.email],
                template: 'VERIFY_EMAIL',
                args: { verification_code }
            });
        });
    }
    enableUser(email, verification_code) {
        return __awaiter(this, void 0, void 0, function* () {
            let user = yield this.findUser({ email });
            if (!user)
                throw 'user not found';
            let { user_id } = user;
            let verification_type = 'ENABLE_ACCOUNT';
            let verification = yield this.verificationRepository.findOne({
                where: { user_id, verification_type },
                order: { created_at: 'DESC' }
            });
            if (dayjs(verification.expires_at).isBefore(dayjs()))
                throw 'code expired';
            if (verification.verification_code !== verification_code)
                throw 'wrong verification code';
            return yield this.usersRepository
                .createQueryBuilder()
                .update(user_entity_1.User)
                .set({ user_status: 'ENABLED' })
                .where("user_id = :user_id", { user_id })
                .returning('*')
                .execute();
        });
    }
    editUser(user_id, userData) {
        return __awaiter(this, void 0, void 0, function* () {
            let columns = [
                'profile_name',
            ];
            let changedPart = {};
            columns.forEach(key => changedPart[key] = userData[key]);
            let { raw } = yield this.usersRepository
                .createQueryBuilder()
                .update(user_entity_1.User)
                .set(changedPart)
                .where("user_id = :user_id", { user_id })
                .returning('*')
                .execute();
            raw.forEach(user => delete user.email);
            return raw === null || raw === void 0 ? void 0 : raw[0];
        });
    }
    queryUsers(reqQuery) {
        var _a, _b;
        return __awaiter(this, void 0, void 0, function* () {
            let [page, size] = [Number((_a = reqQuery.page) !== null && _a !== void 0 ? _a : 0), Number((_b = reqQuery.size) !== null && _b !== void 0 ? _b : 10)];
            let [content, total] = yield this.usersRepository.findAndCount({
                take: size,
                skip: page * size,
                order: {
                    created_at: "DESC"
                }
            });
            let totalPage = Math.ceil(total / size);
            return { content, page, size, total, totalPage };
        });
    }
    findUser(query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.usersRepository.findOne(query);
        });
    }
    findUserWithPwd({ email }) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.usersRepository
                .createQueryBuilder('user')
                .where("user.email = :email", { email })
                .addSelect("user.password")
                .getOne();
        });
    }
    findVerification(query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.verificationRepository.findOne({
                where: query,
                order: { created_at: 'DESC' }
            });
        });
    }
};
UsersService = __decorate([
    common_1.Injectable(),
    __param(0, typeorm_1.InjectRepository(user_entity_1.User)),
    __param(1, typeorm_1.InjectRepository(verification_entity_1.Verification)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        message_service_1.MessageService])
], UsersService);
exports.UsersService = UsersService;
//# sourceMappingURL=users.service.js.map