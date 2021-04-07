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
exports.FilesController = void 0;
const files_service_1 = require("./files.service");
const jwt_guard_1 = require("../auth/jwt.guard");
const platform_express_1 = require("@nestjs/platform-express");
const common_1 = require("@nestjs/common");
let FilesController = class FilesController {
    constructor(filesService) {
        this.filesService = filesService;
    }
    queryGames(query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.filesService.queryFiles(query);
        });
    }
    getGameById(file_id) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.filesService.findFile({ file_id });
        });
    }
    addFile(req, body) {
        return __awaiter(this, void 0, void 0, function* () {
            body.created_by = req.payload.user_id;
            return yield this.filesService.addFile(body);
        });
    }
    updateFileContent(req, file_id, fileContent) {
        return __awaiter(this, void 0, void 0, function* () {
            let file = yield this.filesService.findFile({ file_id });
            if (!file)
                throw new common_1.HttpException('file not found', common_1.HttpStatus.BAD_REQUEST);
            if (file.created_by !== req.payload.user_id)
                throw new common_1.HttpException('only admin or file owner can update', common_1.HttpStatus.FORBIDDEN);
            return yield this.filesService.updateFileContent(file, fileContent);
        });
    }
    updateFile(req, file_id, body) {
        return __awaiter(this, void 0, void 0, function* () {
            let file = yield this.filesService.findFile({ file_id });
            if (file.created_by !== req.payload.user_id)
                throw new common_1.HttpException('only admin or file owner can update', common_1.HttpStatus.FORBIDDEN);
            return yield this.filesService.updateFile(file_id, body);
        });
    }
    deleteFile(req, file_id) {
        return __awaiter(this, void 0, void 0, function* () {
            let file = yield this.filesService.findFile({ file_id });
            if (!file)
                throw new common_1.HttpException('file not found', common_1.HttpStatus.BAD_REQUEST);
            if (file.created_by !== req.payload.user_id)
                throw new common_1.HttpException('only admin or file owner can update', common_1.HttpStatus.FORBIDDEN);
            return yield this.filesService.deleteFile(file_id);
        });
    }
};
__decorate([
    common_1.Get(),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Query()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "queryGames", null);
__decorate([
    common_1.Get('/:file_id'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Param('file_id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "getGameById", null);
__decorate([
    common_1.Post(),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "addFile", null);
__decorate([
    common_1.Put('/:file_id/content'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    common_1.UseInterceptors(platform_express_1.FileInterceptor('file')),
    __param(0, common_1.Req()), __param(1, common_1.Param('file_id')), __param(2, common_1.UploadedFile()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object, Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "updateFileContent", null);
__decorate([
    common_1.Put('/:file_id'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Param('file_id')), __param(2, common_1.Body()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object, Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "updateFile", null);
__decorate([
    common_1.Delete('/:file_id'),
    common_1.UseGuards(jwt_guard_1.JwtAuthGuard),
    __param(0, common_1.Req()), __param(1, common_1.Param('file_id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "deleteFile", null);
FilesController = __decorate([
    common_1.Controller('files'),
    __metadata("design:paramtypes", [files_service_1.FilesService])
], FilesController);
exports.FilesController = FilesController;
//# sourceMappingURL=files.controller.js.map