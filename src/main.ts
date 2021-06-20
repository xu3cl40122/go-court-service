import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from './exception/httpException';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // cors setting
  app.enableCors({
    "allowedHeaders": ['Content-Type', 'Authorization'],
    "exposedHeaders": ['Content-Type', 'Authorization'],
    "origin": "*",
    "methods": "GET,HEAD,PUT,PATCH,POST,DELETE",
    "preflightContinue": false,
    "optionsSuccessStatus": 204
  })

  // create api spec
  const config = new DocumentBuilder()
    .setTitle('GO-COURT API spec')
    .setVersion('1.0')
    // .addTag('cats')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  app.useGlobalFilters(new HttpExceptionFilter());
  app.useGlobalPipes(new ValidationPipe());

  await app.listen(3000);
}
bootstrap();
