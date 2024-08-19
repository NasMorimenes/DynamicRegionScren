#Include <StructCpp>
Name := "BITMAPINFOHEADER"
Members :=
	(
	"DWORD biSize;
  LONG  biWidth;
  LONG  biHeight;
  WORD  biPlanes;
  WORD  biBitCount;
  DWORD biCompression;
  DWORD biSizeImage;
  LONG  biXPelsPerMeter;
  LONG  biYPelsPerMeter;
  DWORD biClrUsed;
  DWORD biClrImportant;"
	)

Values := [ 0, 10, 10, 1, 32, 50, 0 ]

Ass := StructCpp( Name, Members, Values)