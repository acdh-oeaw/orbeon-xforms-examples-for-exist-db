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
import module namespace console="http://exist-db.org/xquery/console";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:media-type "application/xml";

(: Build URL for query to Flickr :)
let $flickrURL := "https://www.flickr.com/services/rest/?method=" ||
                  (if (request:get-method() = 'POST') then
                  let $query := request:get-data()/*
                  return "flickr.photos.search&amp;text=" || encode-for-uri($query)
                  else "flickr.interestingness.getList")
                  || "&amp;per_page=200&amp;api_key=d0c3b54d6fbc1ed217ecc67feb42568b",
    $flickrResponse := hc:send-request(
      <hc:request method = "GET"
                    href = "{$flickrURL}"
      />),
    $photosElements := $flickrResponse//photos/*
(:    , $log := console:dump():)
return <photos> {
    for $photo in $photosElements
        let $photoURL := "https://static.flickr.com/" || $photo/@server || "/" || $photo/@id
            || "_" || $photo/@secret || "_s.jpg",
            $pageURL := "https://flickr.com/photos/" || $photo/@owner || "/" || $photo/@id || "/"
    return <photo url="{$photoURL}" page="{$pageURL}"/>
    }
</photos>
