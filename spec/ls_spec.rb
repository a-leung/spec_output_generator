RSpec.describe 'ls spec' do
  it 'gets output from ls by hand' do
    setup_aruba
    run('ls /')

    output =
      "bin\n"\
      "boot\n"\
      "dev\n"\
      "etc\n"\
      "home\n"\
      "initrd.img\n"\
      "lib\n"\
      "lib64\n"\
      "lost+found\n"\
      "media\n"\
      "mnt\n"\
      "opt\n"\
      "proc\n"\
      "root\n"\
      "run\n"\
      "sbin\n"\
      "srv\n"\
      "sys\n"\
      "tmp\n"\
      "usr\n"\
      "var\n"\
      "vmlinuz\n"

    stop_all_commands
    expect(last_command_started.output).to eq(output)
  end

  it 'records program output', record: true do
    setup_aruba
    run('ls /')

    stop_all_commands
    expect(last_command_started.output).to_not be_nil

    ls_output = last_command_started.output
    File.open('spec/output/ls_output.txt', 'wb') { |f| f.write(ls_output) }
  end

  it 'gets output from ls from file' do
    setup_aruba
    run('ls /')

    begin
      output = File.read('spec/output/ls_output.txt')
      stop_all_commands
      expect(last_command_started.output).to eq(output)
    rescue
      puts ''
      puts "WARNING: missing 'spec/output/ls_output.txt' file for spec"
      puts 'run rspec again'
    end
  end
end
