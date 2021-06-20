import { Test, } from '@nestjs/testing';
import { GamesController } from './games.controller';
import { GamesService } from './games.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Game } from '../../entity/game.entity';
import { GameUser } from '../../entity/game_user.entity';
import { GameTicket } from '../../entity/game_ticket.entity';
import { GameStock } from '../../entity/game_stock.entity';
import { TicketsService } from '../tickets/tickets.service'
import { CreateGameDto, UpdateGameDto } from '../../dto/game.dto'
import { HttpException, HttpStatus } from '@nestjs/common'


describe('GamesController', () => {
  let gamesController: GamesController;
  let gamesService: GamesService;
  let req = { payload: { user_id: 'test_user_id' } }
  let mockGame = new Game()

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      // 要把要用到 Repository import 進來
      imports: [
        // TicketsService
        // TypeOrmModule.forFeature([Game, GameUser, GameTicket, GameStock])
      ],
      providers: [
        GamesService,
        TicketsService,

        // mock 掉和資料庫連接的部分
        {
          provide: getRepositoryToken(Game),
          useValue: {}
        },
        {
          provide: getRepositoryToken(GameUser),
          useValue: {}
        },
        {
          provide: getRepositoryToken(GameTicket),
          useValue: {}
        },
        {
          provide: getRepositoryToken(GameStock),
          useValue: {}
        },
      ],
      controllers: [GamesController],
    }).compile();

    gamesService = moduleRef.get<GamesService>(GamesService);
    gamesController = moduleRef.get<GamesController>(GamesController);
    req = { payload: { user_id: 'test_user_id' } }
    mockGame = new Game()
    mockGame.game_id = 'game_id'
    mockGame.host_user_id = 'host_user_id'
    mockGame.game_status = 'PENDING'
  });

  describe('Update Game', () => {
    it('should throw error if not requested by game host user', async () => {
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame);
      expect(gamesController.updateGame(req, mockGame.game_id, mockGame)).rejects.toThrow()
    });

    it('should update success if request by game host user', async () => {
      mockGame.host_user_id = req.payload.user_id
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame);
      jest.spyOn(gamesService, 'updateGame').mockImplementation(async () => mockGame);
      expect(await gamesController.updateGame(req, mockGame.game_id, mockGame)).toEqual(mockGame)
    });
  });

  describe('Update Game Stock', () => {
    it('should throw error if not requested by game host user', async () => {
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame);
      expect(gamesController.updateGameStock(req, mockGame.game_id, mockGame)).rejects.toThrow()
    });

    it('should update success if request by game host user', async () => {
      let body: any = []
      mockGame.host_user_id = req.payload.user_id
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame);
      jest.spyOn(gamesService, 'updateGameStock').mockImplementation(async () => body);
      expect(await gamesController.updateGameStock(req, mockGame.game_id, body)).toBe(body)
    });
  });

  describe('Init game', () => {
    it('should throw error if not requested by game host user', async () => {
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame);
      await expect(gamesController.initGame(req, mockGame.game_id))
        .rejects.toEqual(new HttpException('only admin or host user can init game', HttpStatus.FORBIDDEN))
    });

    it('should throw error if game status is not PENDING', async () => {
      mockGame.game_status = 'PLAYING'
      mockGame.host_user_id = req.payload.user_id
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame);
      // 這樣寫才能精準測試 throw 出來的東西是否符合預期
      await expect(gamesController.initGame(req, mockGame.game_id))
        .rejects.toEqual(new HttpException('game_status is not PENDING', HttpStatus.NOT_ACCEPTABLE))
    });

    it('should change game status from PENDING TO PLAYING if request by host user', async () => {
      mockGame.game_status = 'PENDING'
      mockGame.host_user_id = req.payload.user_id


      let game_id = 'game_id'
      jest.spyOn(gamesService, 'findGame').mockImplementation(async () => mockGame);
      jest.spyOn(gamesService, 'initGame').mockImplementation(async () => mockGame);
      expect(await gamesController.initGame(req, game_id)).toEqual(mockGame)
    });

  });

});