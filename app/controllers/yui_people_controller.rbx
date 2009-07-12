class YuiPeopleController < ApplicationController
  
  layout 'admin_yui'
  # layout 'admin_jquery'
  
  def index
    @people = Person.find(:all)
  end
  
  def populate
    Person.delete_all
    Degree.delete_all
    Section.delete_all
    Log.delete_all
    Status.delete_all
    Employee.delete_all
    Student.delete_all
    ContactType.delete_all
    Contact.delete_all
    (ctem = ContactType.new(:name => 'email', :is_private => true)).save
    (ctph = ContactType.new(:name => 'phone', :is_private => false)).save
    (stact = Status.new(:name => 'active')).save
    (stinact = Status.new(:name => 'inactive')).save
    (stother = Status.new(:name => 'other')).save
    (secrs = Section.new(:name => 'RS')).save
    (seclx = Section.new(:name => 'LX')).save
    (seclf = Section.new(:name => 'LF')).save
    (dglxmj = Degree.new(:name => 'LX major', :section_id => seclx.id)).save
    (dglxmn = Degree.new(:name => 'LX minor', :section_id => seclx.id)).save
    (dglfmj = Degree.new(:name => 'LF major', :section_id => seclf.id)).save
    (dglfmn = Degree.new(:name => 'LF minor', :section_id => seclf.id)).save
    (ph = Person.new(:name => 'Paul Hagstrom')).save
    (js = Person.new(:name => 'Joe Student')).save
    (ps = Person.new(:name => 'Pierre Student')).save
    (es = Person.new(:name => 'Ed Staff')).save
    ctem.reload
    ctph.reload
    stact.reload
    stinact.reload
    stother.reload
    secrs.reload
    seclx.reload
    seclf.reload
    dglxmj.reload
    dglxmn.reload
    dglfmj.reload
    dglfmn.reload
    ph.reload
    js.reload
    ps.reload
    es.reload
    (Student.new(:person_id => js.id, :status_id => stact.id , :degree_id => dglxmj.id, :graduating => 2010, :graduated => false)).save
    (Student.new(:person_id => ps.id, :status_id => stinact.id , :degree_id => dglfmj.id, :graduating => 2011, :graduated => false)).save
    (Student.new(:person_id => ps.id, :status_id => stact.id , :degree_id => dglxmn.id, :graduating => 2011, :graduated => false)).save
    (Employee.new(:person_id => ph.id, :section_id => seclx.id , :blurb => 'Is alive.', :is_advisor => true)).save
    (Employee.new(:person_id => es.id, :section_id => secrs.id , :blurb => 'Is alive.', :is_advisor => false)).save
    (Contact.new(:person_id => ph.id, :contact_type => ctph , :body => '123-456-7890')).save
    (Contact.new(:person_id => js.id, :contact_type => ctph , :body => '123-456-7890')).save
    (Contact.new(:person_id => ps.id, :contact_type => ctph , :body => '123-456-7890')).save
    (Contact.new(:person_id => es.id, :contact_type => ctph , :body => '123-456-7890')).save
    (Contact.new(:person_id => ph.id, :contact_type => ctem , :body => 'a@b.c')).save
    (Contact.new(:person_id => js.id, :contact_type => ctem , :body => 'a@b.c')).save
    (Contact.new(:person_id => ps.id, :contact_type => ctem , :body => 'a@b.c')).save
    (Contact.new(:person_id => es.id, :contact_type => ctem , :body => 'a@b.c')).save
    (Log.new(:person_id => js.id, :body => 'This is a note.'))
    (Log.new(:person_id => ps.id, :body => 'This is a note.'))
    redirect_to :action => 'index'
    
  end
  
end
