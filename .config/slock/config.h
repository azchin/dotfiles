/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#08060d",     /* after initialization */
	[INPUT] =  "#002e1a",   /* during input */
	[FAILED] = "#690000",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;

/* default message */
static const char * message = "0xF00DBABE";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
/* static const char * font_name = "6x10"; */

static const char * font_name = "-misc-dejavu sans mono-medium-r-normal--0-0-0-0-m-0-iso8859-1";
