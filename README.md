<img src="https://github.com/User1a222121/GeoJSONTest/blob/main/GeoJSONTest.gif" width="380" height="750">

# GeoJSONTest
Передать запрос серверу на получение координат (https://waadsu.com/api/russia.geo.json).
Данные в формате GeoJSON.

Получить список GPS координат от сервера и отрисовать на карте в виде контура по внешним
границам России (внутренние контуры областей считать и отрисовывать не надо).  

Особо обратите внимание на часть России за 180 меридианом (Чукотский полуостров). 
Он должен быть отрисован цельно с остальной частью России.

Посчитать длину внешних границ России, по этим координатам включая все острова.
И отрисовать ее там же на карте. При нажатии на какую-либо часть карты России выделить
другим цветом регион, где произошло нажатие.

Код должен соответствовать Clean Architecture, а также принципам разработки KISS и DRY.

Unit tests с positive и negative testing - обязательны. 

От вас:
Требуется исходный код для осуществления вышеперечисленных действий.
Добавьте побольше комментариев, чтобы мы могли понять лучше вашу логику
выбор карты и как ее отрисовать оставляем за вами.
Вы можете использовать гугл карты или яндекс карты и любые другие карты, требуемые языки
указаны в вакансии).

