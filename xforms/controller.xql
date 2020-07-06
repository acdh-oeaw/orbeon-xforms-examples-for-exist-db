xquery version "3.1";

(:import module namespace console="http://exist-db.org/xquery/console";:)
            
declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;
switch (true())
    case contains($exist:path, '/images/') return 
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="/apps/{replace($exist:controller, '/xforms' ,'/xforms-xml', 'q')}{$exist:path}"/>
      </dispatch>
    default return
    (: everything is passed through :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="no"/>
    </dispatch>