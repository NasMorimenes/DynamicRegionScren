void ProcessColorMode( int rr, int gg, int bb, unsigned char *Bmp, unsigned char *ss, int sw, int sh, int Stride, int n) {
    int r, g, b, v, o = 0, i = 0, j = Stride - sw * 4;
    for (int y = 0; y < sh; y++, o += j)
        for (int x = 0; x < sw; x++, o += 4, i++) {
            r = Bmp[2 + o] - rr;
            g = Bmp[1 + o] - gg;
            b = Bmp[o] - bb;
            v = r + rr + rr;
            ss[i] = ((1024 + v) * r * r + 2048 * g * g + (1534 - v) * b * b <= n) ? 1 : 0;
        }
}

