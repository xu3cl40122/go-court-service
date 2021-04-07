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
exports.MessageService = void 0;
const common_1 = require("@nestjs/common");
const AWS = require("aws-sdk");
let MessageService = class MessageService {
    constructor() { }
    sendMessage(params) {
        return __awaiter(this, void 0, void 0, function* () {
            let { ToAddresses, template, args } = params;
            // Provide the full path to your config.json file. 
            // AWS.config.loadFromPath('./aws.config.json');
            // Replace sender@example.com with your "From" address.
            // This address must be verified with Amazon SES.
            const sender = "tom lee <xu3cl40122@gmail.com>";
            let Message;
            switch (template) {
                case 'VERIFY_EMAIL':
                    Message = this.setVerificationCodeTemplate(args);
                default:
                    break;
            }
            // Create a new SES object. 
            let ses = new AWS.SES();
            // Specify the parameters to pass to the API.
            let option = {
                Source: sender,
                Destination: {
                    ToAddresses
                },
                Message
            };
            //Try to send the email.
            return new Promise((resolve, reject) => {
                ses.sendEmail(option, function (err, data) {
                    err ? reject(err) : resolve(data);
                });
            });
        });
    }
    // 驗證碼信件 template
    setVerificationCodeTemplate(args) {
        const charset = "UTF-8";
        const subject = "GO COURT 驗證信";
        const body_text = `您的驗證碼為 ${args.verification_code}`;
        const body_html = `<html>
<body>
  <h4>您的驗證碼</h4>
  <h2>${args.verification_code}</h2>

  <p>GO COURT Team</p>
</body>
</html>`;
        return {
            Subject: {
                Data: subject,
                Charset: charset
            },
            Body: {
                Text: {
                    Data: body_text,
                    Charset: charset
                },
                Html: {
                    Data: body_html,
                    Charset: charset
                }
            }
        };
    }
};
MessageService = __decorate([
    common_1.Injectable(),
    __metadata("design:paramtypes", [])
], MessageService);
exports.MessageService = MessageService;
//# sourceMappingURL=message.service.js.map