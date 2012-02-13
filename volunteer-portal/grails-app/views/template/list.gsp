<%@ page import="org.codehaus.groovy.grails.commons.ConfigurationHolder; au.org.ala.volunteer.Template" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="${ConfigurationHolder.config.ala.skin}"/>
        <g:set var="entityName" value="${message(code: 'template.label', default: 'Template')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'template.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="author" title="${message(code: 'template.author.label', default: 'Author')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'template.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="viewName" title="${message(code: 'template.viewName.label', default: 'View Name')}" />
                        
                            <g:sortableColumn property="fieldOrder" title="${message(code: 'template.fieldOrder.label', default: 'Field Order')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${templateInstanceList}" status="i" var="templateInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${templateInstance.id}">${fieldValue(bean: templateInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: templateInstance, field: "author")}</td>
                        
                            <td>${fieldValue(bean: templateInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: templateInstance, field: "viewName")}</td>
                        
                            <td>${fieldValue(bean: templateInstance, field: "fieldOrder")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${templateInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
