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
exports.AppModule = void 0;
const common_1 = require("@nestjs/common");
const app_controller_1 = require("./app.controller");
const app_service_1 = require("./app.service");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const users_module_1 = require("./module/users/users.module");
const auth_module_1 = require("./module/auth/auth.module");
const config_1 = require("@nestjs/config");
const courts_module_1 = require("./module/courts/courts.module");
const games_module_1 = require("./module/games/games.module");
const message_module_1 = require("./module/message/message.module");
const files_module_1 = require("./module/files/files.module");
const AWS = require("aws-sdk");
let AppModule = class AppModule {
    constructor(connection) {
        this.connection = connection;
        AWS.config.loadFromPath('./aws.config.json');
    }
};
AppModule = __decorate([
    common_1.Module({
        imports: [
            typeorm_1.TypeOrmModule.forRoot(),
            // can get env setting
            config_1.ConfigModule.forRoot({
                isGlobal: true,
                envFilePath: 'app.env'
            }),
            users_module_1.UsersModule,
            auth_module_1.AuthModule,
            courts_module_1.CourtModule,
            games_module_1.GamesModule,
            message_module_1.MessageModule,
            files_module_1.FilesModule,
        ],
        controllers: [app_controller_1.AppController],
        providers: [app_service_1.AppService],
    }),
    __metadata("design:paramtypes", [typeorm_2.Connection])
], AppModule);
exports.AppModule = AppModule;
//# sourceMappingURL=app.module.js.map