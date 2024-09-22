import { UsuarioService } from './usuario.service';
export declare class UsuarioController {
    private readonly usuarioService;
    constructor(usuarioService: UsuarioService);
    getUser(email: string, senha: string): Promise<{
        id_usuario: string;
        nome_usuario: string;
        email: string;
        senha: string;
    }>;
}
