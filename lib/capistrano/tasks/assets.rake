# frozen_string_literal: true

namespace :assets do
  task :compile do
    run_locally do
      execute :npm, "run webpack:build"
    end
  end
end
