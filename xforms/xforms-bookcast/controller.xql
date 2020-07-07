xquery version "3.1";

import module namespace transform = "http://exist-db.org/xquery/transform";
import module namespace console="http://exist-db.org/xquery/console";
            
declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

try {
switch (true())
    case contains($exist:path, '/images/') return 
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="/apps/{replace($exist:controller, '/xforms/' ,'/xforms-xml/', 'q')}{$exist:path}"/>
      </dispatch>
    (: boiler plate logic to redirect to index.html in all variants people usually use :)
    case $exist:path = '' return
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="/apps/{$exist:controller}/view.xhtml"/>
      </dispatch>
    case $exist:path = '/' return
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="view.xhtml"/>
      </dispatch>
    case $exist:path = '/atom' return (
        transform:transform(doc('/db/apps'||replace($exist:controller, '/xforms/', '/data/')||'/books.xml'), 'xmldb:///db/apps'||$exist:controller||'/atom.xsl', ())
    )
    default return
    (: everything is passed through :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="no"/>
    </dispatch>
} catch * { 
    console:log($err:code||' '||$err:description||': '||$exerr:xquery-stack-trace),
    <exception>
      {$err:code}{$err:description}
      {$err:additional}
    </exception>
}