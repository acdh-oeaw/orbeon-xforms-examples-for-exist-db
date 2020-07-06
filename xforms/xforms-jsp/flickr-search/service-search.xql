(:
    Copyright (C) 2006 Orbeon, Inc.
    Copyright (C) 2020 Omar Siam
    Copyright (C) 2020 ACDH-CH ÖAW

    This program is free software; you can redistribute it and/or modify it under the terms of the
    GNU Lesser General Public License as published by the Free Software Foundation; either version
    2.1 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU Lesser General Public License for more details.

    The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
:)

(:
    response.setContentType("application/xml");
    final SAXReader xmlReader = new SAXReader(XMLParsing.newXMLReader(XMLParsing.ParserConfiguration.PLAIN));

    // Build URL for query to Flickr
    String flickrURL = "https://www.flickr.com/services/rest/?method=";
    if ("POST".equals(request.getMethod())) {
        // We got a query string
        final Document queryDocument = xmlReader.read(request.getInputStream());
        final String query = queryDocument.getRootElement().getStringValue();
        flickrURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&text=" + URLEncoder.encode(query, "UTF-8");
    } else {
        // No query, return interesting photos
        flickrURL += "flickr.interestingness.getList";
    }
    flickrURL += "&per_page=200&api_key=d0c3b54d6fbc1ed217ecc67feb42568b";

    final Document flickrResponse = xmlReader.read(new URL(flickrURL));
    final Element photosElement = flickrResponse.getRootElement().element("photos");
:)
let $flickrResponse := (), (: TBD :)
    $photosElement := $flickrResponse//photos
return <photos> {
    for $photo in $photosElement
        let $photoURL := "https://static.flickr.com/" || $photo/@server || "/" || $photo/@id
            || "_" || $photo/@secret || "_s.jpg",
            $pageURL := "https://flickr.com/photos/" || $photo/@owner || "/" || $photo/@id || "/"
    return <photo url="{$photoURL}" page="{$pageURL}"/>
    }
</photos>
