xquery version "3.0";

import module namespace transform = "http://exist-db.org/xquery/transform";
(:import module namespace console="http://exist-db.org/xquery/console";:)
            
declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

((),
switch (true())
    case contains($exist:path, '/images/') return 
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="/apps/{replace($exist:controller, '/xforms/' ,'/xforms-xml/', 'q')}{$exist:path}"/>
      </dispatch>
    (: boiler plate logic to redirect to index.html in all variants people usually use :)
    case $exist:path = '' return
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="/apps/{$exist:controller}examples-xforms.xml"/>
      </dispatch>
    case $exist:path = '/' return
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="examples-xforms.xml"/>
      </dispatch>
    case $exist:path = '/examples-xforms.xml' return (
(:        console:log('$exist:controller'||': '||$exist:controller),:)
(:        console:log('$exist:path'||': '||$exist:path),:)
        transform:transform(doc('/db/apps'||$exist:controller||$exist:path), 'xmldb:///db/apps'||$exist:controller||'/view.xsl', ())
    )
    default return
    (: everything is passed through :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="no"/>
    </dispatch>
)