/obj/item/book/manual/wiki
	name = "Wiki Book Manual"
	desc = "This REALLY shouldn't exist in-game, please contact a coder"
	copyright = TRUE
	protected = TRUE //We absolutely do not want players editing these books, it might fuck up the iframes in them :)
	pages = null //we don't want people opening this book until it fully initializes
	//Wiki Iframes need a decent bit of room, this will be enough to make the readable without having to expand the window immediately
	book_height = 800
	book_width = 800
	///The Article title of the wiki page being opened in the <iframe>, must use underscores '_' and not whitespace for spaces in title
	var/wiki_article_title = "Space_Law"
	var/hispania_article_title = "spacelaw" //valor default
	var/hispania_article = TRUE

/obj/item/book/manual/wiki/Initialize()
	. = ..()
	if(hispania_article) //revisa si el libro tiene la variable hispania article true, si no lo inicializa para paradise
		pages = list({"
		<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /></head><body bgcolor='[book_bgcolor]'>
		<a href="http://hispaniastation.net/[hispania_article_title]">Continuar</a>
		</body></html>"})
	else
		pages = list({"
		<html><head></head><body bgcolor='[book_bgcolor]'>
		<iframe width='100%' height='97%' src="[GLOB.configuration.url.wiki_url]/index.php/[wiki_article_title]?action=render" frameborder="0" id="main_frame"></iframe>
		</body></html>"})

/obj/item/book/manual/wiki/security_space_law
	name = "Space Law"
	desc = "A set of Nanotrasen guidelines for keeping law and order on their space stations."
	icon_state = "bookSpaceLaw"
	force = 4 //advanced magistrate tactics
	author = "Nanotrasen"
	title = "Space Law"
	wiki_article_title = "Space_law"
	hispania_article = TRUE
	hispania_article_title = "spacelaw"