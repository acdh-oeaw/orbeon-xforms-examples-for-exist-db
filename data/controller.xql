xquery version "3.0";

import module namespace console="http://exist-db.org/xquery/console";

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

try {
switch (true())
    case request:get-method() = 'GET' and $exist:path = '/xforms-bookcast/books.xml' return
        doc('/db/apps'||$exist:controller||'/books.xml')
    case request:get-method() = 'PUT' and $exist:path = '/xforms-bookcast/books.xml' return
        let $stored-file := xmldb:store('/db/apps'||$exist:controller||'/xforms-bookcast', 'books.xml', request:get-data())
        return (console:log('storing'), console:dump(),
          doc($stored-file)/*
        )
    default return ()
} catch * { 
    console:log($err:code||' '||$err:description||': '||$exerr:xquery-stack-trace),
    <exception>
      {$err:code}{$err:description}
      {$err:additional}
    </exception>
}