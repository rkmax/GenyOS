#define VIDEO_MEMORY 0xb8000

int GenyKernel_Main()
{
	char *str = "GenySO is online!", *ch;
	unsigned short *vidmem = (unsigned short*) VIDEO_MEMORY;
	unsigned i;

	for (ch = str, i = 0; *ch; ch++, i++) {
		vidmem[i] = (unsigned char) *ch | 0x0700;
	}

	return 0;
}