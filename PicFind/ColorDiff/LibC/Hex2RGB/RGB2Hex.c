// Função para converter valores RGB para hexadecimal
unsigned int RGB2Hex(unsigned int r, unsigned int g, unsigned int b) {
    // Faz o shift dos valores RGB e os combina em um único valor hexadecimal
    return (r << 16) + (g << 8) + b;
}