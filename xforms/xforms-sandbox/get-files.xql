xquery version "3.1";

declare variable $root := replace(system:get-module-load-path(), '^(xmldb:exist)?(://)?(embedded-eXist-server)?(.*)$' ,'$4');

declare function local:get-collections($collection) {
    let $subcollections :=
        for $child in xmldb:get-child-collections($collection)
        let $collpath := concat($collection, "/", $child)
        return $collpath
    let $resources :=
        for $resource in xmldb:get-child-resources($collection)
        where ends-with($resource, '.xhtml')
        return <file name="{$resource}"/>
    return <directory name="{replace($collection, $root, '')}">{$subcollections!(local:get-collections(.)), $resources}</directory>
};

local:get-collections($root||'/samples'),util:log-system-out('get-files')