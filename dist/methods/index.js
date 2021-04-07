"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateVerificationCode = void 0;
function generateVerificationCode(length = 6) {
    return Math.random()
        .toString()
        .replace('0.', '')
        .slice(0, length);
}
exports.generateVerificationCode = generateVerificationCode;
//# sourceMappingURL=index.js.map