import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let path = "./recipes.txt"
  echo get_list_of_documents(path)
}

fn get_list_of_documents(path: String) -> List(String) {
  let documents =
    path
    |> simplifile.is_file
    |> result.then(fn(is_file) {
      case is_file {
        True -> simplifile.read(from: path)
        False -> Error(simplifile.Enoent)
      }
    })
    |> result.map(fn(content) { "File content:\n" <> content })
    |> result.unwrap("Error")
    |> string.split("\n")

  documents
}
