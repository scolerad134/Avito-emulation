<!DOCTYPE html>
<html>
<head>
    <title>Avito emulation</title>
</head>
<body>
<h1>Avito emulation</h1>
<h3>Подробная информация о пользователе ${user.name}</h3>
<b>Номер телефона: ${user.phoneNumber}</b><br>
<b>Email: ${user.email}</b><br>
<hr>
<h4>Товары пользователя:</h4>
<#list products as product>
    <div>
        <p><b>${product.title}</b> ${product.price} руб. | <a href="/product/${product.id}">Подробнее...</a></p>
    </div>
<#else>
    <h3>Товаров нет</h3>
</#list>
</body>
</html>