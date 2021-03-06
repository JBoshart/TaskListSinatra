require 'sqlite3'
require_relative 'database.rb'

class TaskHandler < TaskList::Database
  attr_accessor :db

  def initialize(dbname = "tasks")
    @db = SQLite3::Database.new("database/#{dbname}.db")
  end

  def list_all
    @db.execute("SELECT * FROM tasklist;")
  end

  def create_task(task_info)
    @db.execute("INSERT INTO tasklist (title, description, completed_at)
    VALUES (:title, :description, :completed_at);", task_info)
  end

  def complete_task(done_ids)
    done_ids.each do |id|
      @db.execute("UPDATE tasklist SET completed_at = date('now') WHERE id=?", (id))
    end
  end

  def find_task(id)
    @db.get_first_row("SELECT * FROM tasklist WHERE id=?;", id)
  end

  def update_task(update)
    @db.execute("UPDATE tasklist SET title = ?, description = ?, completed_at = ? WHERE id=?", update[1], update[2], update[3], update[0])
  end


  def delete_task(deleteid)
    @db.execute("DELETE FROM tasklist WHERE id=?", deleteid)
  end

end
