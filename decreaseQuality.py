from PIL import ImageGrab, Image, ImageDraw
import pyautogui

def take_screenshot(output_path):
    screenshot = ImageGrab.grab()
    screenshot.save(output_path)

def draw_mouse_cursor(input_path, output_path):
    image = Image.open(input_path)
    draw = ImageDraw.Draw(image)

    cursor_position = (pyautogui.position()[0], pyautogui.position()[1])
    cursor_size = 10

    # Draw a red cross to represent the mouse cursor
    draw.line([(cursor_position[0] - cursor_size, cursor_position[1]),
               (cursor_position[0] + cursor_size, cursor_position[1])], fill="red", width=2)
    draw.line([(cursor_position[0], cursor_position[1] - cursor_size),
               (cursor_position[0], cursor_position[1] + cursor_size)], fill="red", width=2)

    # Save the result
    image.save(output_path)

if __name__ == "__main__":
    result_path = "screen.png"

    take_screenshot(result_path)
    draw_mouse_cursor(result_path, result_path)