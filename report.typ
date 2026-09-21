#set document(
  title: "Лабораторная работа №1",
  author: "Герасюто Фадей Александрович",
)

#set page(paper: "a4", margin: 2cm)

#set text(
  lang: "ru",
  size: 14pt,
  font: ("Liberation Serif", "Libertinus Serif"),
)

#set par(justify: false, leading: 0.75em)

#align(center)[
  Федеральное государственное автономное образовательное учреждение высшего образования

  #text(weight: "bold")[«Национальный исследовательский университет ИТМО»]

  #v(0.4em)
  #line(length: 40%, stroke: 0.6pt)
  #v(0.4em)

  #text(style: "italic")[Факультет систем управления и робототехники]
]

#v(1fr)

#align(center)[
  #text(size: 22pt, weight: "bold", tracking: 0.05em)[ЛАБОРАТОРНАЯ РАБОТА №1]

  #v(0.6em)

  по дисциплине #text(weight: "bold")[«Программирование на Python»]

  #v(1.4em)

  #text(size: 16pt)[Вариант 10]
]

#v(1fr)

#align(right)[
  #block(width: 9cm)[
    #set align(left)

    *Выполнил:* \
    Герасюто Фадей Александрович \
    Группа: R3140

    #v(1em)

    *Преподаватель:* \
    Шорохов Сергей Александрович
  ]
]

#v(1fr)

#align(center)[Санкт-Петербург, 2026]

#pagebreak()

// Со второй страницы: нумерация и заголовки
#set page(numbering: "1")
#set heading(numbering: "1.1.")

#outline(title: "Содержание")

#pagebreak()

= Задание

+ Сгенерировать при помощи escape-символов в консоли изображение флага, соответствующее варианту.
+ Сгенерировать в консоли повторяющийся узор.
+ Используя функцию очистки консольного вывода (`os.system("cls")` или `os.system("clear")`), а также последовательности управления курсором, реализовать анимацию из 3–4 кадров.
+ Используя файл с числовой последовательностью `sequence.txt`, вывести диаграмму процентного соотношения двух чисел (количество в группе или сумма) согласно варианту, исходя из того, что сумма этих двух чисел равна 100~%.
+ Дополнительное задание: сгенерировать (не вывести построчно) в консоли первую четверть графика функции при помощи escape-символов, высотой не менее 9 строк.

Вариант 10: флаг Швейцарии, узор `j`, функция y = x / 3, диаграмма по условию «числа от -3 до 3 и остальные».

#pagebreak()

= Листинг программы

```python
import os
from time import sleep

RED = '\u001b[41m'
GREEN = '\u001b[42m'
BLUE = '\u001b[44m'
WHITE = '\u001b[47m'
END = '\u001b[0m'
CELL = '  '

RING = [
    '  ###  ',
    ' #   # ',
    '#     #',
    '#     #',
    '#     #',
    ' #   # ',
    '  ###  ',
]


def draw_flag():
    WIDTH, HEIGHT = 25, 15
    MARGIN_V = HEIGHT*0.2
    MARGIN_H = (WIDTH - HEIGHT) // 2 + MARGIN_V

    for row in range(HEIGHT):
        line = ''
        for col in range(WIDTH):
            vertical = abs(col - WIDTH // 2) <= 1 and MARGIN_V <= row < HEIGHT - MARGIN_V
            horizontal = abs(row - HEIGHT // 2) <= 1 and MARGIN_H <= col < WIDTH - MARGIN_H
            color = WHITE if vertical or horizontal else RED
            line += f'{color}{CELL}{END}'
        print(line)


def draw_pattern(across=2, down=3):
    for _ in range(down):
        for row in RING:
            print(''.join(f'{BLUE}{CELL}{END}' if c == '#' else CELL for c in row * 2 * across))


def draw_function(height=9):
    width = 3 * (height - 1) + 1  # y = x / 3
    for y in range(height - 1, -1, -1):
        cells = ''.join(f'{GREEN}{CELL}{END}' if round(x / 3) == y else CELL for x in range(width))
        print(f'{y:2d} |{cells}')
    print('   +' + '—' * 2 * width)
    print('    ' + ''.join(f'{x:<2}' if x % 3 == 0 else CELL for x in range(width)))


def draw_sequence_diagram(path='sequence.txt'):
    with open(path) as f:
        numbers = [float(line) for line in f]

    total = len(numbers)
    inside = len([n for n in numbers if -3 <= n <= 3])
    outside = total - inside
    width = 35
    cells_inside = round(inside/total * width)

    print(f'{GREEN}{CELL * cells_inside}{RED}{CELL * (width - cells_inside)}{END}')
    print(f'{GREEN}{CELL}{END} от -3 до 3: {inside / total:.1%} ({inside})')
    print(f'{RED}{CELL}{END} остальные:  {outside / total:.1%} ({outside})')


def animate():
    frames = [
        RED + '  ' * 10 + END,
        WHITE + '  ' * 3 + RED + '  ' * 7 + END,
        WHITE + '  ' * 5 + RED + '  ' * 5 + END,
        WHITE + '  ' * 7 + RED + '  ' * 3 + END,
        WHITE + '  ' * 10 + END,
    ]
    for frame in frames:
        os.system('clear')
        print(frame)
        sleep(0.5)


if __name__ == '__main__':
    draw_flag()
    print()
    draw_pattern()
    print()
    draw_function()
    print()
    draw_sequence_diagram()
    input('\nEnter — запустить анимацию...')
    animate()

```

#pagebreak()

// ── 4. Вывод ────────────────────────────────────────────
= Вывод

В ходе работы я изучил escape-последовательности ANSI и научился с их помощью выводить в консоль цветные изображения. Была написана программа, которая рисует флаг Швейцарии, повторяющийся узор, график функции y = x / 3 и диаграмму по числам из файла, а также показывает анимацию из пяти кадров.
