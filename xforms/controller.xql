xquery version "3.1";

(:import module namespace console="http://exist-db.org/xquery/console";:)
declare namespace oxfc = "http://www.orbeon.com/oxf/controller";

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

switch (true())
    case contains($exist:path, '/images/') or contains($exist:path, '/img/') return 
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="/apps/{replace($exist:controller, '/xforms' ,'/xforms-xml', 'q')}{$exist:path}"/>
      </dispatch>
    case (ends-with($exist:path, '/') and doc-available('/db/apps'||$exist:controller||$exist:path||'page-flow.xml')) return
      let $page-flow := doc('/db/apps'||$exist:controller||$exist:path||'page-flow.xml'),
          $default-page := ($page-flow/oxfc:controller/oxfc:page[@path = ('*', $exist:path)]/@view, 'view.xhtml')[1]
      return <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="{$default-page}"/>
      </dispatch>
    case (xmldb:collection-available('/db/apps'||$exist:controller||$exist:path) and doc-available('/db/apps'||$exist:controller||$exist:path||'/page-flow.xml')) return
      let $page-flow := doc('/db/apps'||$exist:controller||$exist:path||'/page-flow.xml'),
          $default-page := ($page-flow/oxfc:controller/oxfc:page[@path = ('*', $exist:path)]/@view, 'view.xhtml')[1]
      return <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="{substring($exist:path, 2)}/{$default-page}"/>
      </dispatch>
    default return
    (: everything is passed through :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="no"/>
    </dispatch>