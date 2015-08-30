# Postgresql Discovery Vagrant Box

## Прежде, чем начать

Многие разработчики уже давно используют ``Vagrant`` для построения воспроизводимых окружений. Это очень удобно, так как он позволяет отлаживать конфигурацию окружения локально и легко передавать её другим разработчикам.

Если у вас ещё не установлен ``Vagrant`` и ``VirtualBox``, сейчас самое время их установить:

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Для тех, кто не знаком с Vagrant

``Vagrant`` &mdash; это фронтэнд к утилитам управления виртуальными машинами. Все рутинные операции с его помощью сводятся в нескольким командам:

```
vagrant up          # Создать виртуальную машину и воспроизвести окружение
vagrant destroy -f  # Сбросить состояние и выключить виртуальную машину
vagrant suspend     # Заморозить состояние и выключить виртуальную машину
vagrant ssh         # Войти на виртуальную машину по протоколу ssh
```

Первый вызов команды ``vagrant up`` потребует скачать образ ``ubuntu/trusty64``, весит он около 400Мб. Получение образа &mdash; единовременная операция и в дальнейшем повторяться не будет.

## Развёртывание окружения

Скопируйте ```Vagrantfile.dist``` в ```Vagrantfile```:

```
cp Vagrantfile.dist Vagrantfile
```

``Vagrantfile`` преднамеренно убран из-под контроля версий, так как в дальнейшем вы можете пожелать внести в него наиболее удобные для вас изменения.

После этого выполните команду ``vagrant up``.

В результате будет создана виртуальная машина с необходимыми пакетами для работы и копией репозитория ``Postgresql``. Войти на неё можно с помощью команды ``vagrant ssh``.

## Остановка окружения

При выполении команды ``vagrant destroy`` состояние виртуальной машиы будет сброшено. Следующий вызов ``vagrant up`` вновь будет разворачивать окружение.

Поэтому для остановки рекомендуется использовать команду ``vagrant suspend`` &mdash; тогда окружение будет сохранено, а виртуальная машина остановлена. Следующий вызов ``vagrant up`` потребует значительно меньше времени, так как всего лишь включит уже созданную виртуальную машину с окружением.

### Операции, требующие определенного времени

Во время развёртывания вам может показаться, что процесс остановился. Это не так. После вызова команды ``vagrant up`` на виртуальную машину устанавливается система управления конфигурацией ``Saltstack``, затем уже ``Saltstack`` устанавливает пакеты и получает рабочую копию репозитория ``Postgresql``.

Когда вы увидите следующие строки в консоли, значит всё работает правильно:

```
Checking if salt-call is installed
salt-call was not found.
Bootstrapping Salt... (this may take a while)
...
Calling state.highstate... (this may take a while)
```

### Saltstack!?

Многие из вас могут заметить, что всё можно было бы упаковать в небольшой bash-скрипт наподобие следующего:

```
apt-get update
apt-get install -y ...
mkdir ...
git clone ...
```

Возможно, вы будете правы. Но по мере нашего погружения конфигурация будет усложняться: мы будем ставить новые пакеты, клонировать другие репозитории (например, с расширениями) &mdash; дополнять и расширять наше окружение.

В этот момент bash-скрипт превратится в мешанину из команд, которую станет сложно и неприятно поддерживать. В то время как система управления конфигурацией сделать этого не позволит, правила воспроизведения окружения останутся простыми для понимания и изменения.