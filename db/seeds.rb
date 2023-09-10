# frozen_string_literal: true

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'Web Admin Client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'Apps Client', redirect_uri: '', scopes: '')
end

# generate roles
roles = %w[admin operator student teacher guardian speaker]

roles.each do |role|
  Role.find_or_create_by(name: role)
end

# genereate permissions
# actions = %w[read create update destroy]

# object_without_create_list = %w[Stage Coin]
# object_without_update_list = %w[Carnival Refferal]
# object_without_destroy_list = %w[Role Refferal]
# objects = %w[User Role Carnival Camp Stage StageCamp StageCampSchedule Coin Province City]
# actions.each do |action|
#   objects.each do |object|
#     next if object_without_create_list.include?(object) && action.eql?('create')

#     next if object_without_update_list.include?(object) && action.eql?('update')

#     next if object_without_destroy_list.include?(object) && action.eql?('destroy')

#     Permission.find_or_create_by(object_type: object, action_name: action)
#   end
# end

# default_operator_permissions
# operator_id = Role.find_by_name('operator').id
# permissions = Permission.all

# permissions.each do |permission|
#   RolePermission.find_or_create_by(role_id: operator_id, permission_id: permission.id)
# end

# generate default users
default_admin = User.create(
  email: 'admin_client01@mailinator.com',
  password: 'Admin123!'
)

default_admin.update(role_ids: Role.find_by_name('admin').id)
default_admin.build_user_profile(first_name: 'Super', last_name: 'Admin', birth_date: '1995-01-01', phone_number: '08888888').save

# default_student = User.create(
#   email: 'user_client01@mailinator.com',
#   password: 'Admin123!'
# )

# default_student.update(role_ids: Role.find_by_name('student').id)
# default_student.build_user_profile(first_name: 'First', last_name: 'Student', birth_date: '1995-01-01', phone_number: '088888881').save

# generate default carnival
carnival = Carnival.find_or_initialize_by(name: 'Youthcamp - Season 1')
carnival.finished_at = carnival.finished_at || Time.zone.now + 6.month
carnival.status = 'active'
carnival.save!

Coin.names.to_a.each do |name|
  coin = Coin.find_or_initialize_by(name: name[0])
  coin.save!
end

PERSONALITIES = %w[ESTJ ENTJ ESFJ ENFJ ISTJ ISFJ INTJ INFJ ESTP ESFP ENTP ENFP ISTP ISFP INTP INFP].freeze

PERSONALITIES.each do |personality|
  pl = Personality.find_or_initialize_by(code: personality)
  pl.name = personality
  File.open("public/personalities/#{personality.downcase}_char.png") do |f|
    pl.image = f
  end
  pl.save!
end

# J & P
AssessmentQuestion.create(
  question: 'Teman terbaik menurutmu',
  choice_1_text: 'Teman yang mengerti batasan-batasan dan tidak melanggar norma-norma yang berlaku.',
  choice_1_type: 'judging',
  choice_2_text: 'Teman yang bisa mengerti perasaanmu dan mampu memaafkan kesalahanmu.',
  choice_2_type: 'perceiving',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Kamu memilih teman untuk berbisnis, yang kamu pilih adalah teman yang',
  choice_1_text: 'Teman yang serius dan disiplin yang mempersiapkan dengan sebaik mungkin, supaya tidak ada kegagalan.',
  choice_1_type: 'judging',
  choice_2_text: 'Fleksibel menjalani usaha dengan optimis dan menyenangkan.',
  choice_2_type: 'perceiving',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Yang paling menyebalkan menurutmu',
  choice_1_text: 'Menunggu teman yang datang selalu telat.',
  choice_1_type: 'judging',
  choice_2_text: 'Teman yang terlalu serius dan susah diajak becanda.',
  choice_2_type: 'perceiving',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Dalam berteman, yang paling penting adalah',
  choice_1_text: 'Komitmen, saling menghargai dan tepat waktu.',
  choice_1_type: 'judging',
  choice_2_text: 'Jalani dengan mencoba hal-hal baru yang seru.',
  choice_2_type: 'perceiving',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Menurutmu, kamu memiliki sikap pembawaan yang',
  choice_1_text: 'Tegas, disiplin dan teratur.',
  choice_1_type: 'judging',
  choice_2_text: 'Spontan, fleksibel dan mudah beradaptasi.',
  choice_2_type: 'perceiving',
  status: 'active'
)

# I & E
AssessmentQuestion.create(
  question: 'Saat mendengar berita ada teman yang terlibat perkelahian, reaksiku',
  choice_1_text: 'Mencerna dan berpikir lebih dulu.',
  choice_1_type: 'introvert',
  choice_2_text: 'Langsung terkejut dan menunjukkan reaksi.',
  choice_2_type: 'extrovert',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Setiap orang memiliki sosial media, bagaimana kamu mendefinisikan aktivitas kamu dalam sosial media yang kamu miliki?',
  choice_1_text: 'Aku jarang posting, kebanyakan membaca dan menyimak saja karena sosial media bukan real life.',
  choice_1_type: 'introvert',
  choice_2_text: 'Kebanyakan aktifitas aku post di sosial media dan aktif, bagaimanapun social media adalah self-image juga.',
  choice_2_type: 'extrovert',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Apa sudut pandang kamu atau peran kamu saat berteman dan bersosialisasi dalam lingkunganmu?',
  choice_1_text: 'Lebih sering menjadi pendengar yang baik.',
  choice_1_type: 'introvert',
  choice_2_text: 'Lebih aktif bercerita dan membagikan pengalaman terbaik.',
  choice_2_type: 'extrovert',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Dalam pekerjaan kamu, kamu paling produktif dengan cara kerja yang seperti apa?',
  choice_1_text: 'Kerja sendiri dan independen.',
  choice_1_type: 'introvert',
  choice_2_text: 'Biar lebih cepat selesai, kerja kelompok.',
  choice_2_type: 'extrovert',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Setiap orang punya waktu beraktivitas atau bekerja, juga punya waktu luang untuk dihabiskan, bagaimana cara kamu menghabiskan waktu luang?',
  choice_1_text: 'Membaca, menonton atau bersantai dirumah saja.',
  choice_1_type: 'introvert',
  choice_2_text: 'Makan di luar atau ke taman bermain dan bertemu teman.',
  choice_2_type: 'extrovert',
  status: 'active'
)

# T & F
AssessmentQuestion.create(
  question: 'Kamu lebih sering berpikir tentang',
  choice_1_text: 'Masa depan dan bagaimana mencapai target.',
  choice_1_type: 'thinking',
  choice_2_text: 'Menganalisa masa lalu dan menimbang-nimbang peristiwa yang terjadi.',
  choice_2_type: 'feeling',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Saat kamu memiliki bisnis',
  choice_1_text: 'Kamu persiapkan semua dengan detail dan membuat rencana jangka pendek dan jangka panjang.',
  choice_1_type: 'thinking',
  choice_2_text: 'Ikuti ritme bisnis, bagimu yang terpenting bisnis harus dilakukan dengan nyaman dan menyenangkan.',
  choice_2_type: 'feeling',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Bagimu dalam mencapai target yang paling utama adalah',
  choice_1_text: 'Target tercapai karena sudah dengan perhitungan yang matang disertai data dan kemampuan tim.',
  choice_1_type: 'thinking',
  choice_2_text: 'Kekompakan dan sikap saling membantu antar sesama tim.',
  choice_2_type: 'feeling',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Saat kamu berargumentasi, kamu selalu',
  choice_1_text: 'Memberikan data dan analisa lengkap.',
  choice_1_type: 'thinking',
  choice_2_text: 'Kamu menjelaskan dengan pendekatan yang humanis, menjaga perasaan lawan bicara kita.',
  choice_2_type: 'feeling',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Ketika kamu menjadi pemimpin suatu perusahaan, tim kamu tidak mencapai target yang telah disepakati, yang kamu lakukan',
  choice_1_text: 'Memberikan coaching supaya kerja lebih produktif dan efektif.',
  choice_1_type: 'thinking',
  choice_2_text: 'Cari tau beban masalah keluarga yang terjadi.',
  choice_2_type: 'feeling',
  status: 'active'
)

# S & N
AssessmentQuestion.create(
  question: 'Mana yang menjadi fokus hidupmu',
  choice_1_text: 'Masa sekarang.',
  choice_1_type: 'sensing',
  choice_2_text: 'Masa depan.',
  choice_2_type: 'intuition',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Menurutmu mana yang kamu banget',
  choice_1_text: 'Aku adalah orang yang praktis.',
  choice_1_type: 'sensing',
  choice_2_text: 'Aku adalah orang yang konseptual.',
  choice_2_type: 'intuition',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Kamu menjalani kesukaan kamu dengan:',
  choice_1_text: 'Hobinya sama dan itu-itu saja.',
  choice_1_type: 'sensing',
  choice_2_text: 'Selalu ingin mencoba hal baru yang lebih menantang.',
  choice_2_type: 'intuition',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Manakah yang menggambarkan kamu:',
  choice_1_text: 'Mengerjakan suatu proyek dengan cara yang sudah kamu pernah kamu pakai.',
  choice_1_type: 'sensing',
  choice_2_text: 'Mengerjakan suatu proyek dengan cara baru yang unik.',
  choice_2_type: 'intuition',
  status: 'active'
)

AssessmentQuestion.create(
  question: 'Kamu sering menebak-nebak ending sebuah film?',
  choice_1_text: 'Tidak',
  choice_1_type: 'sensing',
  choice_2_text: 'Ya',
  choice_2_type: 'intuition',
  status: 'active'
)
