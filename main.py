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
