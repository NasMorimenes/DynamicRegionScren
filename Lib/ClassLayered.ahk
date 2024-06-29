#Include ClassLayer.ahk

Ass := Layered( "Sigep" )

class Layered {
    
    static layers := Map()

    /*
     * Construtor: Inicializa um objeto Layered com uma lista de camadas vazia.
     */
    __New( Name ) {        
        this.%Name% := Layered.layers
        this.AddLayer( name )
    }

    /*
     * AddLayer: Adiciona uma nova camada e retorna a camada criada.
     *
     * Returns:
     *   newLayer - A nova camada criada.
     */
    AddLayer( Name ) {
        Layered.layers.Set( Name,  )
        ;return newLayer
    }

    /*
     * DrawAll: Desenha todas as camadas na tela fornecida (hdc).
     *
     * Parameters:
     *   hdc - Contexto de dispositivo da tela onde as camadas serão desenhadas.
     */
    DrawAll(hdc) {
        for _, layer in this.layers {
            layer.Draw(hdc)
        }
    }
    
    Load() {

    }
    Save() {

    }

    /*
     * ClearAll: Limpa todas as camadas.
     */
    ClearAll() {
        for _, layer in this.layers {
            layer.Clear()
        }
    }
}
