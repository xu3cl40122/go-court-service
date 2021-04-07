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
exports.FilesService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const file_entity_1 = require("../../entity/file.entity");
// import entire SDK
const AWS = require("aws-sdk");
let FilesService = class FilesService {
    constructor(filesRepository) {
        this.filesRepository = filesRepository;
    }
    findFile(query) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.filesRepository.findOne({
                where: query,
            });
        });
    }
    // game part 
    queryFiles(query) {
        var _a, _b;
        return __awaiter(this, void 0, void 0, function* () {
            let [page, size] = [Number((_a = query.page) !== null && _a !== void 0 ? _a : 0), Number((_b = query.size) !== null && _b !== void 0 ? _b : 10)];
            let { tag, reference_id, created_by } = query;
            let where = {};
            if (tag)
                where.tag = tag;
            if (reference_id)
                where.tag = reference_id;
            if (created_by)
                where.created_by = created_by;
            let [content, total] = yield this.filesRepository.findAndCount({
                where,
                take: size,
                skip: page * size,
            });
            let totalPage = Math.ceil(total / size);
            return { content, page, size, total, totalPage };
        });
    }
    addFile(fileData) {
        return __awaiter(this, void 0, void 0, function* () {
            const file = new file_entity_1.File();
            let columns = [
                'file_name',
                'tag',
                'file_url',
                'created_by',
                'reference_id',
                'is_public',
                'description',
                'meta',
            ];
            columns.forEach(key => file[key] = fileData[key]);
            return yield this.filesRepository.save(file);
        });
    }
    updateFile(file_id, fileData) {
        return __awaiter(this, void 0, void 0, function* () {
            const file = new file_entity_1.File();
            let columns = [
                'file_name',
                'tag',
                'file_url',
                'reference_id',
                'is_public',
                'description',
                'meta',
            ];
            columns.forEach(key => file[key] = fileData[key]);
            let { raw } = yield this.filesRepository
                .createQueryBuilder()
                .update(file_entity_1.File)
                .set(file)
                .where("file_id = :file_id", { file_id })
                .returning('*')
                .execute();
            return raw === null || raw === void 0 ? void 0 : raw[0];
        });
    }
    deleteFile(file_id) {
        return __awaiter(this, void 0, void 0, function* () {
            let s3 = new AWS.S3();
            let params = {
                Bucket: "gc-file-service",
                Key: file_id,
            };
            s3.deleteObject(params).promise();
            return this.filesRepository.delete(file_id);
        });
    }
    updateFileContent(file, fileContent) {
        return __awaiter(this, void 0, void 0, function* () {
            let s3 = new AWS.S3();
            let params = {
                Body: fileContent.buffer,
                Bucket: "gc-file-service",
                Key: file.file_id,
                ACL: file.is_public ? 'public-read' : 'authenticated-read',
                ContentType: fileContent.mimetype
            };
            yield s3.putObject(params).promise().catch(() => { throw 'upload failed'; });
            file.file_url = `https://gc-file-service.s3-us-west-2.amazonaws.com/${file.file_id}`;
            return this.updateFile(file.file_id, file);
        });
    }
};
FilesService = __decorate([
    common_1.Injectable(),
    __param(0, typeorm_1.InjectRepository(file_entity_1.File)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], FilesService);
exports.FilesService = FilesService;
//# sourceMappingURL=files.service.js.map