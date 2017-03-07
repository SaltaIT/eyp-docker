
# [root@puppet2 ~]# docker run -i -v ~/.ssh:/root/.ssh --volumes-from puppetshared -t eyp/puppetmaster grep memory /proc/1/cgroup
# 4:memory:/system.slice/docker-5f71e49305576105fdf3c277bd483248eb4e02a5c726f95283d1d924247bea67.scope
#
# [jprats@croscat ~]$ grep memory /proc/1/cgroup
# 5:memory:/
#
# [jprats@croscat ~]$ docker run -i -v /home/jprats/git/puppet-things:/import --volumes-from=puppetshared -t puppetmaster grep memory /proc/1/cgroup
# 5:memory:/docker/9d935881f3222064bd393b8eda4d42d01eceea841a7733c45658098a83806105


# [jprats@croscat nsh]$ grep -v /$ /proc/1/cgroup | wc -l
# 0
#
# root@474bc61076f5:/# grep -v /$ /proc/1/cgroup | wc -l
# 9

if File.exist?('/proc/1/cgroup')

  cgroup = Facter::Util::Resolution.exec('bash -c \'grep -v /$ /proc/1/cgroup | grep docker | wc -l\'').to_s

  unless cgroup.nil? or cgroup.empty?
    Facter.add('eyp_docker_iscontainer') do
        setcode do
          if cgroup=="0"
            false
          else
            true
          end
        end
    end
  end
end
