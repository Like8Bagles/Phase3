class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)


    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json({:include => :students}) ]]
    elsif req.path.match(/students/)
      if req.env["REQUEST_METHOD"] == "POST"
        input = JSON.parse(req.body.read)
        # binding.pry
        sensei_id = req.path.split('/sensei/').last.split('/students').last
        sensei = Sensei.find_by(id: sensei_id)
        student = sensei.students.create(name: input["name"])
        return [200, { 'Content-Type' => 'application/json' }, [ student.to_json ]]
      elsif req.env["REQUEST_METHOD"] == "DELETE"
        # 
        sensei_id = req.path.split('/sensei/').last.split('/students').first
        sensei = Sensei.find_by(id: sensei_id)
        student_id = req.path.split("/students/").last
        student = sensei.students.find_by(id: student_id)
        # binding.pry
        student.destroy
        return [200, { 'Content-Type' => 'application/json' }, [ student.to_json ]]
      end
    elsif req.path.match(/sensei/)
      if req.env["REQUEST_METHOD"] == "POST"
        input = JSON.parse(req.body.read)
        senseis = Sensei.create(name: input["name"])
        return [200, { 'Content-Type' => 'application/json' }, [ senseis.to_json ]]
      elsif req.env["REQUEST_METHOD"] == "DELETE"
        sensei_id = req.path.split('/sensei/').last
        sensei = Sensei.find_by(id: sensei_id)
        sensei.destroy
        return [200, { 'Content-Type' => 'application/json' }, [ student.to_json ]]
      else
        if req.path.split("/sensei").length == 0
          return [200, { 'Content-Type' => 'application/json' }, [ Sensei.all.to_json ]]
        else
          sensei_id = req.path.split("/sensei/").last
          return [200, { 'Content-Type' => 'application/json' }, [ Sensei.find_by(id: sensei_id).to_json({:include => :students}) ]]
        end
      end
      
    else
      resp.write "Nope"

    end

    resp.finish
  end

end
