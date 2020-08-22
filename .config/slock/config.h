/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#08060d",     /* after initialization */
	[INPUT] =  "#0f0f0f",   /* during input */
	[FAILED] = "#690000",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;
