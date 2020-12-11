file = open('input.txt')
lines = file.readlines()
file.close()

def part_1(lines):
    max_id = -1
    for line in lines:
        lower_row = 0
        upper_row = 127
        lower_col = 0
        upper_col = 7
        for char in line:
            if char == 'F':
                upper_row = (lower_row + upper_row) // 2
            elif char == 'B':
                lower_row = ((lower_row + upper_row) // 2) + 1
            elif char == 'R':
                lower_col = ((lower_col + upper_col) // 2) + 1
            else:
                upper_col = (lower_col + upper_col) // 2

        seat_id = lower_row * 8 + lower_col
        if seat_id > max_id:
            max_id = seat_id
    return max_id

def part_2(lines):
    possible_ids = set(range(0, 1024))
    for line in lines:
        lower_row = 0
        upper_row = 127
        lower_col = 0
        upper_col = 7
        for char in line:
            if char == 'F':
                upper_row = (lower_row + upper_row) // 2
            elif char == 'B':
                lower_row = ((lower_row + upper_row) // 2) + 1
            elif char == 'R':
                lower_col = ((lower_col + upper_col) // 2) + 1
            else:
                upper_col = (lower_col + upper_col) // 2

        seat_id = lower_row * 8 + lower_col
        possible_ids.remove(seat_id)
    print(possible_ids)

print(part_1(lines))
print(part_2(lines))
