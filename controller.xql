xquery version "3.0";
            
declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

switch (true())
    case false() return ()
    (: boiler plate logic to redirect to index.html in all variants people usually use :)
    case $exist:path = '' return
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="/apps/{$exist:controller}/examples-xforms.xml"/>
      </dispatch>
    case $exist:path = '/' return
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="examples-xforms.xml"/>
      </dispatch>
    case $exist:path = ('/examples-xforms.xml') return
      <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="/apps{$exist:controller}/xforms/home/{$exist:path}"/>
      </dispatch>
    (: everything is passed through :)
    default return
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="no"/>
    </dispatch>